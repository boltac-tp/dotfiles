# alias general
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# alias cat
if [[ $(command -v batcat) ]]; then
    alias bat = batcat
    export PAGER='bat'
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif [[ $(command -v bat) ]]; then
    export PAGER='bat'
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

which bat > /dev/null && alias cat='bat'

# alias vim
if [[ $(command -v nvim) ]]; then
    export EDITOR=nvim VISUAL=nvim
fi

which nvim > /dev/null && alias vim='nvim'

# alias exa
if [[ $(command -v exa) ]]; then
  alias l=exa
  alias ls='exa -ahl --git'
  alias la='exa -a'
  alias ll='exa -ahl --git'
  alias lt='exa -T -L 3 -a -I --git'
  alias lta='exa -T -a -I --git --color=always | less -r'
else
  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias la='ls -A'
fi

# apps
alias weather='curl wttr.in/sapporo'


eval "$(sheldon source)"
eval "$(starship init zsh)"
