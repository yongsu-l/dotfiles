#
# ~/.bashrc
#

alias ls='ls --color=auto'
alias scan='connmanctl scan wifi && connmanctl services'
alias security='chromium --proxy-server="127.0.0.1:8080"'
#alias v='nvim'
export PS1='\n\[\033[38;5;241m\]╔ \[\033[1m\]\[\033[91m\]\u\[\033[38;5;240m\]│\[\033[93m\]\h\[\033[38;5;241m\]:\[\033[92m\]\w\[\033[0m\]\n\[\033[38;5;241m\]╚ \[\033[1m\]\[\033[91m\]»\[\033[93m\]»\[\033[92m\]»\[\033[0m\] '
