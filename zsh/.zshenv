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

# xdg_home
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# my scrips
export PATH="$HOME/dotfiles/scripts:$PATH"

# local PATH
export PATH="$HOME/.local/bin:$PATH"

# rust
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export PATH="${CARGO_HOME}/bin:$PATH"

# pyenv
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"

# poetry
export POETRY_CONFIG_DIR="${XDG_CONFIG_HOME}/poetry"
export POETRY_HOME="${XDG_DATA_HOME}/pypoetry"
export POETRY_CACHE_DIR="${XDG_CACHE_HOME}/pypoetry"
export PATH="${POETRY_HOME}/bin:$PATH"

# ruff
export RUFF_CACHE_DIR="${XDG_CACHE_HOME}/ruff"

# go-lang
export GOPATH="${XDG_DATA_HOME}/go" 
export PATH="${PATH}:${GOPATH}/bin"
export PATH=$PATH:/usr/local/go/bin

# volta
export VOLTA_HOME="${XDG_DATA_HOME}/volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# npm
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# deno PATH
export DENO_INSTALL="${XDG_DATA_HOME}/deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

#fpath
fpath=(~/dotfiles/zsh/completions $fpath)
