
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# syntax-hithlighting
zinit load "zsh-users/zsh-syntax-highlighting"
# hystory
zinit load "zsh-users/zsh-history-substring-search"
# completions
zinit load "zsh-users/zsh-autosuggestions"
zinit load "zsh-users/zsh-completions"
zinit load "chrissicool/zsh-256color"

# local PATH
export PATH="$HOME/.local/bin:$PATH"
# rust PATH
export PATH="$HOME/.cargo/bin:$PATH"

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias vim=nvim
alias cat=bat

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# go-lang path
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# apps
alias weather='curl wttr.in/sapporo'

# alias exa
if [[ $(command -v exa) ]]; then
  alias l=exa
  alias ls=exa
  alias la='exa -a'
  alias ll='exa -ahl --git'
  alias lt='exa -T -L 3 -a -I --git'
  alias lta='exa -T -a -I --git --color=always | less -r'
fi

# wslのパスをwinのパスに変換し、winのFirefoxに渡す
if [[ "$(uname)" == Linux ]]; then
  MY_ENV=Linux
  if [[ "$(uname -r)" == *microsoft* ]]; then
    MY_ENV=WSL
  fi
else
  MY_ENV=Windows
fi

if [[ $MY_ENV == WSL ]]; then
  export BROWSER=$HOME/dotfiles/scripts/wsl_browser_path_to_win.sh
fi

fpath+=${ZDOTDIR:-~}/.zsh_functions
