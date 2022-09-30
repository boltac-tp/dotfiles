# 環境の特定
if [[ "$(uname)" = 'Linux' ]] && [[ $(pgrep -c gnome-panel) -gt 0 ]]; then
  MY_ENV=GNOME
elif [[ "$(uname)" = 'Linux' ]] && [[ $(pgrep -c plasmashell) -gt 0 ]]; then
  MY_ENV=KDE
elif [[ "$(uname -r)" = *microsoft* ]]; then
  MY_ENV=WSL
else
  MY_ENV=Windows
fi
export MY_ENV

# local PATH
export PATH="$HOME/.local/bin:$PATH"
# rust PATH
export PATH="$HOME/.cargo/bin:$PATH"
# poetry
export PATH="$HOME/.poetry/bin:$PATH"
# go-lang path
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
# volta path
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
# deno PATH
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# cargo PATH
. "$HOME/.cargo/env"


#fpath
fpath=(~/.zsh/completions $fpath)


# wslのパスをwinのパスに変換し、winのFirefoxに渡す
if [[ $MY_ENV == WSL ]]; then
  export BROWSER=$HOME/dotfiles/scripts/wsl_browser_path_to_win.sh
fi


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

# apps
alias weather='curl wttr.in/sapporo'


eval "$(sheldon source)"
eval "$(starship init zsh)"
