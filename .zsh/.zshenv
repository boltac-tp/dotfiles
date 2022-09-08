export ZDOTDIR="$HOME/.zsh"

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

#fpath
fpath=( ~/.zsh/completion "${fpath[@]}")

# wslのパスをwinのパスに変換し、winのFirefoxに渡す
if [[ "$(uname)" = 'Linux' ]] && [[ $(pgrep -c gnome-panel) -gt 0 ]]; then
  MY_ENV=GNOME
elif [[ "$(uname)" = 'Linux' ]] && [[ $(pgrep -c plasmashell) -gt 0 ]]; then
  MY_ENV=KDE
elif [[ "$(uname -r)" = *microsoft* ]]; then
  MY_ENV=WSL
else
  MY_ENV=Windows
fi

if [[ $MY_ENV == WSL ]]; then
  export BROWSER=$HOME/dotfiles/scripts/wsl_browser_path_to_win.sh
fi

. "$HOME/.cargo/env"
