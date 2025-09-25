# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# tab completion
autoload -Uz compinit && compinit

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/figma/figma:$PATH
export PATH=$HOME/dotfiles/.gitbin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

export TERM=xterm-256color

export GOPATH=$HOME/go

eval "$(~/.local/bin/mise activate zsh)"

set -o vi
export EDITOR=nvim
export VISUAL=$EDITOR

source <(fzf --zsh)
source <(kubectl completion zsh)

unset AWS_CLI_AUTO_PROMPT
unset AWS_PAGER

function assume-role() {
  OUT=$(aws sts assume-role --role-arn $1 --role-session-name $(whoami)@figma.com);\
  export AWS_ACCESS_KEY_ID=$(echo $OUT | jq -r '.Credentials''.AccessKeyId');\
  export AWS_SECRET_ACCESS_KEY=$(echo $OUT | jq -r '.Credentials''.SecretAccessKey');\
  export AWS_SESSION_TOKEN=$(echo $OUT | jq -r '.Credentials''.SessionToken');
}

# git
alias gs="git status"
alias gca="git commit --amend --no-edit"
alias gca="git add -A && git commit --amend --no-edit"
alias gca='git commit --amend --no-edit'
alias gaa='git add -A'
alias gcaa='gaa && gca'
alias gd='git diff'
alias gpf='git push --force'
alias gcaap='gaa && gca && gpf'
function gswitch() {
  git switch $(git branch | fzf)
}
function gg() {
  cd $(git rev-parse --show-toplevel)
}
function ff() {
  cd "$HOME/figma/figma"
}

# auth
alias avd='unset AWS_VAULT && access aws exec devenv01-admin'
alias avg='unset AWS_VAULT && access aws exec gov-readonly'
alias avs='unset AWS_VAULT && access aws exec staging-compute-admin'
alias avp='unset AWS_VAULT && access aws exec production-compute-admin'

# other
alias k='kubectl'
alias vim='nvim'
alias tf='tofu'
alias ls='ls -F'
alias ll='ls -llh'
alias grep='rg'

source $HOME/powerlevel10k/powerlevel10k.zsh-theme

export AWS_CONFIG_FILE="$HOME/figma/figma/config/aws/sso_config"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig:/usr/local/opt/zlib/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig:/usr/local/opt/openssl@3/lib/pkgconfig:$PKG_CONFIG_PATH"

eval "$(rbenv init -)"
export RACK_ENV=development

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

