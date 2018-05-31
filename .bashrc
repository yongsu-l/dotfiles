#
# ~/.bashrc
#

set -o vi

alias ls='ls --color=auto'
export PS1='\n\[\033[38;5;241m\]╔ \[\033[1m\]\[\033[91m\]\u\[\033[38;5;240m\]│\[\033[93m\]\h\[\033[38;5;241m\]:\[\033[92m\]\w\[\033[0m\]\n\[\033[38;5;241m\]╚ \[\033[1m\]\[\033[91m\]»\[\033[93m\]»\[\033[92m\]»\[\033[0m\] '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export EDITOR='nvim'
export BROWSER='chromium'
export IBUS_ENABLE_SYNC_MODE=0
export PATH=$PATH:$HOME/.scripts:$HOME/.local/bin/:$HOME/google-cloud-sdk/bin/
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$HOME/go

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  alias nvm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && nvm'
  alias node='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && node'
  alias npm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && npm'
fi
