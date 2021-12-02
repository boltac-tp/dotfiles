#!/bin/bash

# 利用環境の特定

if [[ "$(uname)" = 'Linux' ]] && [[ $(pgrep -c gnome-panel) -gt 0 ]]; then
  MY_ENV=GNOME
elif [[ "$(uname)" = 'Linux' ]] && [[ $(pgrep -c plasmashell) -gt 0 ]]; then
  MY_ENV=KDE
elif [[ "$(uname -r)" = *microsoft* ]]; then
  MY_ENV=WSL
else
  MY_ENV=Windows
fi

echo $MY_ENV
sudo apt update && sudo apt upgrade -y

if [[ $MY_ENV = GNOME ]] || [[ $MY_ENV = KDE ]]; then
  sudo apt remove --purge "libreoffice*" -y
  ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
  sudo apt install -y tmux
  sudo add-apt-repository ppa:solaar-unifying/stable -y
  sudo apt update
  sudo apt install -y solaar

  if [[ $MY_ENV = GNOME ]]; then
    # script for Ubuntu
    LANG=C xdg-user-dirs-gtk-update
    sudo snap remove --purge firefox -y
    sudo apt install -y keepassxc gnome-tweaks firefox
  elif [[ $MY_ENV = KDE ]]; then
    # script for Kubuntu
    sudo apt install -y xdg-user-dirs gnome-keyring
    LANG=C xdg-user-dirs-update --force
  fi
fi

# install some dev dependency
sudo apt install -y cmake curl pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev libssl-dev

# zshのインストール

sudo apt install -y zsh
mkdir ~/.zsh
ln -s ~/dotfiles/.zshenv ~/.zshenv
ln -s ~/dotfiles/.zshrc ~/.zsh/.zshrc
ln -s ~/dotfiles/.zlogin ~/.zsh/.zlogin
ln -s ~/dotfiles/.zimrc ~/.zsh/.zimrc
sudo apt install -y shellcheck

sudo chsh -s $(which zsh) $(whoami)

sudo install -y openssh-client socat

# gitのインストール

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update && sudo apt install -y git
ln -s ~/dotfiles/.gitconfig ~/.gitconfig

# フォントのインストール
HACK_GEN_NERD_VER=` git ls-remote https://github.com/yuru7/HackGen | grep refs/tags | grep -oE "v[0-9]\.[0-9][0-9]?\.[0-9][0-9]?" | sort --version-sort | tail -n 1`
PLEMOL_NERD_VER=` git ls-remote https://github.com/yuru7/Plemoljp | grep refs/tags | grep -oE "v[0-9]\.[0-9][0-9]?\.[0-9][0-9]?" | sort --version-sort | tail -n 1`
if [[ $MY_ENV != WSL ]]; then
  wget -q https://github.com/yuru7/HackGen/releases/download/${HACK_GEN_NERD_VER}/HackGenNerd_${HACK_GEN_NERD_VER}.zip
  unzip HackGenNerd_${HACK_GEN_NERD_VER}.zip
  sudo cp HackGenNerd_${HACK_GEN_NERD_VER}/HackGenNerdConsole* /usr/local/share/fonts
  rm -rf HackGenNerd*
  wget -q https://github.com/yuru7/PlemolJP/releases/download/${PLEMOL_NERD_VER}/PlemolJP_${PLEMOL_NERD_VER}.zip
  unzip PlemolJP_${PLEMOL_NERD_VER}.zip
  sudo cp PlemolJP_${PLEMOL_NERD_VER}/PlemolJPConsole/PlemolJPConsole* /usr/local/share/fonts
  rm -rf PlemolJP*
fi

# nodeのインストール

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs
mkdir -p ~/.local/bin
npm config set prefix=$HOME/.local
npm install -g npm yarn pnpm

# pythonのインストール

sudo apt install -y python3-venv python3-pip
if [ ! -d /usr/bin/python3.9 ]; then
  sudo apt install python3.9 python3.9-venv python3.9-dev -y
fi
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python3 - 
~/.local/bin/poetry config virtualenvs.in-project true

# rustのインストール

curl https://sh.rustup.rs -sSf | sh -s -- -y

# goのインストール
GO_VER=`git ls-remote https://github.com/golang/go | grep refs/tags | grep -oE "[0-9]\.[0-9][0-9]?\.[0-9][0-9]?" | sort --version-sort | tail -n 1`
wget -q https://golang.org/dl/go${GO_VER}.linux-amd64.tar.gz
if [ -d /usr/local/go ]; then
   sudo rm -rf /usr/local/go
fi
sudo tar -C /usr/local -xzf go${GO_VER}.linux-amd64.tar.gz
rm go${GO_VER}.linux-amd64.tar.gz

# vimのインストール
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update && sudo apt install -y vim neovim
ln -s ~/dotfiles/nvim ~/.config/nvim

# その他のapp
~/.cargo/bin/cargo install exa bat cargo-update cargo-edit

/usr/local/go/bin/go get github.com/jesseduffield/lazygit
mkdir -p ~/.config/jesseduffield/lazygit
ln -s ~/dotfiles/lazygit/config.yml ~/.config/jesseduffield/lazygit/config.yml

