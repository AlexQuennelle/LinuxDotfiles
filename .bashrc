#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Dotfiles config setups
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
