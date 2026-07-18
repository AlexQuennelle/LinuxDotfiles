alias logout='loginctl kill-session "$XDG_SESSION_ID"'
alias ls='ls --color=auto'
alias grep='rg --color=auto'
alias rg='rg --color=auto'
alias su='su -m'
alias fzvim='nvim $(ls -a | fzf)'
PS1='[\u@\h \W]\$ '

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/Alex/.zshrc'

autoload -Uz compinit
compinit

_comp_options+=(globdots) # With hidden files
source <(fzf --zsh)
source /home/Alex/.config/zshPlugins/fzf-tab/fzf-tab.plugin.zsh

source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fpath=(/usr/share/zsh/site-functions $fpath)

setopt autocd
unsetopt extendedglob
bindkey -v

setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

dirStack() {
	local dir
	dir=$(dirs -lp | fzf --bind 'esc:abort')
	[ -n "$dir" ] && cd "$dir"
}
alias d=dirStack

# test whether $SSH_AUTH_SOCK is valid
ssh-add -l 2>/dev/null >/dev/null
# if not valid, then start ssh-agent using $SSH_AUTH_SOCK
if [ $? -ge 2 ]; then
	ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
	ssh-add
fi

[ -f "/home/Alex/.ghcup/env" ] && . "/home/Alex/.ghcup/env" # ghcup-env

eval "$(starship init zsh)"

clear && fastfetch
