# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### ssh-agent ###
# /usr/bin/keychain --absolute --dir "$XDG_RUNTIME_DIR"/keychain -q --nogui ~/.ssh/id_rsa
# source $XDG_RUNTIME_DIR/keychain/$HOST-sh

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
fi
export PAGER='bat'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

which bat > /dev/null && alias cat='bat'

# alias vim
if [[ $(command -v nvim) ]]; then
    export EDITOR=nvim VISUAL=nvim
fi

which nvim > /dev/null && alias vi='nvim'

# hook pkg-file
source /usr/share/doc/pkgfile/command-not-found.zsh

# alias exa
if [[ $(command -v eza) ]]; then
  alias l=eza
  alias ls='eza -ahl --git'
  alias la='eza -a'
  alias ll='eza -ahl --git'
  alias lt='eza -T -L 3 -a -I --git'
  alias lta='eza -T -a -I --git --color=always | less -r'
else
  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias la='ls -A'
fi

# alias atcoder
alias acctp='oj t -c "rye run python main.py" -d ./test/'
alias acctpp='oj t -c "rye run pypy main.py" -d ./test/'
alias accspp='acc s main.py -- --guess-python-interpreter pypy'

alias ac='cargo compete'

# alias some scritps
alias myupdate='myupdate.sh'

# apps
alias weather='curl wttr.in/sapporo'
alias pbcopy='xsel --clipboard --input'

# direnv init
eval "$(direnv hook zsh)"

# rye init
source "${RYE_HOME}/env"

# sheldon init
eval "$(sheldon source)"

[ -f "/home/boltac/.ghcup/env" ] && source "/home/boltac/.ghcup/env" # ghcup-envsource

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# zsh completion
fpath=(/usr/local/share/zsh/site-functions $fpath)
fpath=(~/dotfiles/zsh/completions $fpath)
autoload -U compinit
compinit -d ~/.local/share/zsh/compdump


# bun completions
[ -s "/home/boltac/.bun/_bun" ] && source "/home/boltac/.bun/_bun"
