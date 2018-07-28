#
# ~/.bashrc
#

set -o vi

alias ls='ls --color=auto'
alias vim="nvim"
export PS1=" \[\e[00;34m\]λ \W \[\e[0m\]"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export EDITOR='nvim'
export IBUS_ENABLE_SYNC_MODE=0
export PATH=$PATH:$(go env GOPATH)/bin:$HOME/.local/bin
export GOPATH=$HOME/go

export PATH=$PATH:$HOME/.scripts

