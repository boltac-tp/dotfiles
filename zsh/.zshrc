### ssh-agent ###
/usr/bin/keychain -q --nogui ~/.ssh/id_rsa
source ~/.keychain/$HOST-sh

# wslのパスをwinのパスに変換し、winのFirefoxに渡す
if [[ $MY_ENV == WSL ]]; then
  export BROWSER=$HOME/dotfiles/scripts/wsl_browser_path_to_win.sh
fi

# setopt
unsetopt glob_dots
unsetopt ignore_eof
setopt no_flow_control
setopt auto_cd
setopt auto_pushd
setopt no_beep
setopt no_list_beep
setopt auto_list
setopt list_packed
setopt auto_param_keys
setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt auto_menu
setopt complete_in_word
setopt magic_equal_subst

# alias general
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# alias cat
if [[ $(command -v batcat) ]]; then
    alias bat ='batcat'
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

# alias atcoder
alias acctp='oj t -c "python3 main.py" -d ./test/'
alias acctpp='oj t -c "pypy main.py" -d ./test/'
alias accspp='acc s main.py -- --guess-python-interpreter pypy'

# alias some scritps
alias myupdate='myupdate.sh'

# apps
alias weather='curl wttr.in/sapporo'
alias wezterm='flatpak run org.wezfurlong.wezterm'
alias pbcopy='xsel --clipboard --input'

eval "$(sheldon source)"
eval "$(starship init zsh)"
