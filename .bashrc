#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias logout='loginctl kill-session "$XDG_SESSION_ID"'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias su='su -m'
alias fzvim='nvim $(ls -a | fzf)'
PS1='[\u@\h \W]\$ '

# Dotfiles config setups
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias cc='clang'
alias c++='clang++'

# alias ghci='clear && ghci'

# init starship
eval "$(starship init bash)"

[ -f "/home/Alex/.ghcup/env" ] && . "/home/Alex/.ghcup/env" # ghcup-env
export EDITOR=nvim
export QT_QPA_PLATFORMTHEME="qt5ct"

# set SSH_AUTH_SOCK env var to a fixed value
export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock

# test whether $SSH_AUTH_SOCK is valid
ssh-add -l 2>/dev/null >/dev/null


# if not valid, then start ssh-agent using $SSH_AUTH_SOCK
if [ $? -ge 2 ]; then
	ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
	ssh-add
fi
clear && fastfetch
