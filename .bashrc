#
# ~/.bashrc
#

set -o vi

alias ls='ls --color=auto'
export PS1=" \[\e[00;34m\]λ \W \[\e[0m\]"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export EDITOR='nvim'
export IBUS_ENABLE_SYNC_MODE=0
export PATH=$PATH:$HOME/.scripts:$HOME/.local/bin/:$HOME/google-cloud-sdk/bin/
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$HOME/go
