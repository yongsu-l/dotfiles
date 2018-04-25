#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR='vim'
export BROWSER='firefox'
export IBUS_ENABLE_SYNC_MODE=0
export PATH=$PATH:$HOME/.scripts:$HOME/.local/bin/:$HOME/google-cloud-sdk/bin/
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$HOME/go

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
