
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias vim=nvim
alias cat=bat

# apps
alias weather='curl wttr.in/sapporo'

# alias exa
if [[ $(command -v exa) ]]; then
  alias l=exa
  alias ls='exa -ahl --git'
  alias la='exa -a'
  alias ll='exa -ahl --git'
  alias lt='exa -T -L 3 -a -I --git'
  alias lta='exa -T -a -I --git --color=always | less -r'
fi

eval "$(sheldon source)"
