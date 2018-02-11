#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
export EDITOR='vim'
export IBUS_ENABLE_SYNC_MODE=0
export PS1='\n\[\033[38;5;241m\]╔ \[\033[1m\]\[\033[91m\]\u\[\033[38;5;240m\]│\[\033[93m\]\h\[\033[38;5;241m\]:\[\033[92m\]\w\[\033[0m\]\n\[\033[38;5;241m\]╚ \[\033[1m\]\[\033[91m\]»\[\033[93m\]»\[\033[92m\]»\[\033[0m\] '
#PS1="\[$(tput bold)\]\[$(tput setaf 1)\] \W\[$(tput setaf 0)\] λ \[$(tput sgr0)\]"
PATH="${PATH}:${HOME}/.local/bin/"
