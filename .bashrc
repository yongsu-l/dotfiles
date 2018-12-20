#
# ~/.bashrc
#

set -o vi

alias ls='ls -F'
alias vim="nvim"
alias tmux="tmux -2"
alias feh="feh --scale-down --auto-zoom"
export PS1=" \[\e[00;34m\]λ \W \[\e[0m\]"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
 export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

export EDITOR='nvim'
export PATH=$PATH:$(go env GOPATH)/bin:$HOME/.local/bin:~/.npm-global/bin
export GOPATH=$HOME/go

export PATH=$PATH:$HOME/.scripts
export PATH=$PATH:$HOME/.config/composer/vendor/bin
export PATH=$PATH:/home/yong/android-studio/bin
export PATH=$PATH:/home/yong/anaconda3/bin

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
