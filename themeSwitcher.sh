if [[ "$1" ]]; then
	theme="$1"
else
	read -p "Theme: " theme
fi
if [[ "${theme^}" = "Carbon" ]]; then # Carbonfox
	sed -i -e "s/color_scheme =.*/color_scheme = 'carbonfox'/" .wezterm.lua
	sed -i -e "s/gradient.*)/gradient(to right, #78a9ff, #be95ff)/" .config/waybar/style.css
	sed -i -e "s/background:.*/background: #161616;/" .config/waybar/style.css
	awk -v line=2 '$1=="background:" && ++count==line{
		$0="  background: #7b7c7e;"
	} 1' .config/waybar/style.css > temp_file && mv temp_file .config/waybar/style.css
	sed -i -e "s/\.active_border.*).*)/\.active_border = rgba(78a9ffff) rgba(be95ffff)/" .config/hypr/hyprland.conf
	sed -i -e "s/inactive_border.*)/inactive_border = rgba(7b7c7eff)/" .config/hypr/hyprland.conf
	sed -i -e "s/hypr.*/hypr\/bg.png/" .config/hypr/hyprpaper.conf
	sed -i -e "s/colorscheme.*/colorscheme('carbonfox')/" .config/nvim/init.lua
	hyprctl hyprpaper reload ,".config/hypr/bg.png"
	pkill waybar && hyprctl dispatch exec waybar
elif [[ "${theme^}" = "Tera" ]]; then # Terafox
	sed -i -e "s/color_scheme =.*/color_scheme = 'terafox'/" .wezterm.lua
	sed -i -e "s/gradient.*)/gradient(to right, #fda47f, #ad5c7c)/" .config/waybar/style.css
	sed -i -e "s/background:.*/background: #0f1c1e;/" .config/waybar/style.css
	awk -v line=2 '$1=="background:" && ++count==line{
		$0="  background: #587b7b;"
	} 1' .config/waybar/style.css > temp_file && mv temp_file .config/waybar/style.css
	sed -i -e "s/\.active_border.*).*)/\.active_border = rgba(fda47fff) rgba(ad5c7cff)/" .config/hypr/hyprland.conf
	sed -i -e "s/inactive_border.*)/inactive_border = rgba(587b7bff)/" .config/hypr/hyprland.conf
	sed -i -e "s/hypr.*/hypr\/tera.jpeg/" .config/hypr/hyprpaper.conf
	sed -i -e "s/colorscheme.*/colorscheme('terafox')/" .config/nvim/init.lua
	hyprctl hyprpaper reload ,".config/hypr/tera.jpeg"
	pkill waybar && hyprctl dispatch exec waybar
elif [[ "${theme^}" = "Rose" ]]; then # Rose Pine
	sed -i -e "s/color_scheme =.*/color_scheme = 'rose-pine'/" .wezterm.lua
	sed -i -e "s/gradient.*)/gradient(to right, #ebbcba, #ebbcba)/" .config/waybar/style.css
	sed -i -e "s/background:.*/background: #191724;/" .config/waybar/style.css
	awk -v line=2 '$1=="background:" && ++count==line{
		$0="  background: #403d52;"
	} 1' .config/waybar/style.css > temp_file && mv temp_file .config/waybar/style.css
	sed -i -e "s/\.active_border.*).*)/\.active_border = \$rose \$pine \$love \$iris 90deg/" .config/hypr/hyprland.conf
	sed -i -e "s/inactive_border.*)/inactive_border = \$muted/" .config/hypr/hyprland.conf
	sed -i -e "s/hypr.*/hypr\/rose_pine_shape.png/" .config/hypr/hyprpaper.conf
	sed -i -e "s/colorscheme.*/colorscheme('rose-pine')/" .config/nvim/init.lua
	hyprctl hyprpaper reload ,".config/hypr/rose_pine_shape.png"
	pkill waybar && hyprctl dispatch exec waybar
elif [[ "${theme^}" = "Mocha" ]]; then # Catppuccin Mocha
	# TODO: finish implementing theme
	sed -i -e "s/color_scheme =.*/color_scheme = 'Catppuccin Mocha'/" .wezterm.lua
	sed -i -e "s/gradient.*)/gradient(to right, #fda47f, #ad5c7c)/" .config/waybar/style.css
	sed -i -e "s/background:.*/background: #0f1c1e;/" .config/waybar/style.css
	awk -v line=2 '$1=="background:" && ++count==line{
		$0="  background: #587b7b;"
	} 1' .config/waybar/style.css > temp_file && mv temp_file .config/waybar/style.css
	sed -i -e "s/\.active_border.*).*)/\.active_border = rgba(fda47fff) rgba(ad5c7cff)/" .config/hypr/hyprland.conf
	sed -i -e "s/inactive_border.*)/inactive_border = rgba(587b7bff)/" .config/hypr/hyprland.conf
	sed -i -e "s/hypr.*/hypr\/tera.jpeg/" .config/hypr/hyprpaper.conf
	sed -i -e "s/colorscheme.*/colorscheme('catppuccin')/" .config/nvim/init.lua
	hyprctl hyprpaper reload ,".config/hypr/tera.jpeg"
	pkill waybar && hyprctl dispatch exec waybar
else
	echo "Invalid theme"
fi
