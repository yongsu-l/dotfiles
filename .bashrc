#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias scan='connmanctl scan wifi && connmanctl services'
alias security='chromium --proxy-server="127.0.0.1:8080"'
#alias v='nvim'
export EDITOR='vim'
export BROWSER='firefox'
export IBUS_ENABLE_SYNC_MODE=0

export PATH="$PATH:$HOME/.local/bin/:$HOME/google-cloud-sdk/bin/"
export PS1='\n\[\033[38;5;241m\]╔ \[\033[1m\]\[\033[91m\]\u\[\033[38;5;240m\]│\[\033[93m\]\h\[\033[38;5;241m\]:\[\033[92m\]\w\[\033[0m\]\n\[\033[38;5;241m\]╚ \[\033[1m\]\[\033[91m\]»\[\033[93m\]»\[\033[92m\]»\[\033[0m\] '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
# export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -s "$HOME/.rvm/scripts/rvm"  ]] && source "$HOME/.rvm/scripts/rvm"
