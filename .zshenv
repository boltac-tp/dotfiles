# Start configuration added by Zim install {{{
#
# User configuration sourced by all invocations of the shell
#

# Define Zim location
#: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}
# }}} End configuration added by Zim install

export ZDOTDIR=$HOME/.zsh
export ZIM_HOME=$HOME/.zim

# local PATH
export PATH="$HOME/.local/bin:$PATH"
# rust PATH
export PATH="$HOME/.cargo/bin:$PATH"
# poetry
export PATH="$HOME/.poetry/bin:$PATH"
# go-lang path
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

fpath+=${ZDOTDIR:-~}/.zsh_functions

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

. "$HOME/.cargo/env"
