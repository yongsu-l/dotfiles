#
# ~/.bashrc
#

set -o vi

alias ls='ls --color=auto'
alias vim="nvim"
alias intellij="idea"
export PS1=" \[\e[00;34m\]λ \W \[\e[0m\]"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export EDITOR='nvim'
export IBUS_ENABLE_SYNC_MODE=0
export PATH=$PATH:$(go env GOPATH)/bin:$HOME/.local/bin:~/.npm-global/bin
export GOPATH=$HOME/go

export PATH=$PATH:$HOME/.scripts

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
