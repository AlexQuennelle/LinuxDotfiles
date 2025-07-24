#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -euo pipefail

find_hyprland_socket() {
    local runtime_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

    if [ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
        return 1 # Indicate failure
    fi

    # echo "$runtime_dir/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
	echo "$runtime_dir/hypr/$(hyprctl instances -j | jq '.[] | .instance')/.socket2.sock"
    return 0
}

HYPRLAND_SOCKET=$(find_hyprland_socket)
if [ $? -ne 0 ]; then
    exit 1
fi

processWorkspace() {
	local workspaceWindows="$(hyprctl clients -j | jq --argjson id "$1" '
	[.[] |
		select(. .workspace.id == $id) |
		select(. .floating == false)]')"
	local windowCount="$(echo $workspaceWindows | jq length)"
	local pWindows="$(echo $workspaceWindows | jq -r '[.[] | select(. .pseudo)]')"
	local pWindowCount="$(echo $pWindows | jq length)"
	if [[ "$windowCount" > "1" ]];
	then
		if [[ "$pWindowCount" > "0" ]];
		then
			local pWindowNames="$(echo $pWindows | jq -r '.[] | .address')"
			while IFS= read -r pWindow; do
				local cleaned="$(echo $pWindow | tr -d '\r')"
				hyprctl dispatch pseudo address:"$cleaned"
			done <<< "$pWindowNames"
		fi
	elif [[ "$windowCount" == "1" ]];
	then
		wezterms="$(echo $workspaceWindows | jq '[.[] | select(. .pseudo == false) | select(. .class == "org.wezfurlong.wezterm")]')"
		if [[ "$(echo $wezterms | jq -r length)" == "1" ]];
		then
			wezAddr="$(echo $wezterms | jq -r '.[] | .address')"
			hyprctl dispatch pseudo address:"$wezAddr"
		fi
	fi
}

# socat UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while IFS= read -r line; do
socat UNIX-CONNECT:"$HYPRLAND_SOCKET" - | while IFS= read -r line; do
    if [[ "$line" == "openwindow"* ]] \
	|| [[ "$line" == "closewindow"* ]] \
	|| [[ "$line" == "movewindowv2"* ]];
	then
		workspaces="$(hyprctl workspaces -j | jq -c '
		.[] | select(. .id >= 1) | .id')"
		while IFS= read -r workspace; do
			processWorkspace $workspace
		done <<< "$workspaces"
    fi
done
