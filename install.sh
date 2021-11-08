#!/bin/bash

# 利用環境の特定

if [ "$(uname)" == 'Linux' ]; then
  MY_ENV=Linux
  if [[ "$(uname -r)" == *microsoft* ]]; then
    MY_ENV=WSL
  fi
else
  MY_ENV=Windows
fi

echo $MY_ENV

if [[ $MY_ENV = Linux ]]; then
  # defalut directory
  LANG=C xdg-user-dirs-gtk-update

  # install apps for ubuntu-desktop
  sudo apt update
  sudo apt install tmux keepassxc gnome-tweaks
  sudo apt remove --purge "libreoffice*"
  ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
fi

sudo apt update && sudo apt upgrade -y

# install some dev dependency
sudo apt update
sudo apt install cmake curl pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev libssl-dev -y

# zshのインストール

sudo apt update && sudo apt install -y zsh
mkdir ~/.zsh
ln -s ~/dotfiles/.zshenv ~/.zshenv
ln -s ~/dotfiles/.zshrc ~/.zsh/.zshrc
ln -s ~/dotfiles/.zlogin ~/.zsh/.zlogin
ln -s ~/dotfiles/.zimrc ~/.zsh/.zimrc
sudo apt install -y shellcheck

sudo chsh -s $(which zsh) $(whoami)

sudo apt update && sudo apt install -y openssh-client socat

# gitのインストール

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update && sudo apt install -y git
ln -s ~/dotfiles/.gitconfig ~/.gitconfig

# フォントのインストール
HACK_GEN_NERD_VER='v2.5.1'
if [[ $MY_ENV != WSL ]]; then
  wget https://github.com/yuru7/HackGen/releases/download/${HACK_GEN_NERD_VER}/HackGenNerd_${HACK_GEN_NERD_VER}.zip
  unzip HackGenNerd_${HACK_GEN_NERD_VER}.zip
  sudo cp HackGenNerd_${HACK_GEN_NERD_VER}/HackGenNerdConsole* /usr/local/share/fonts
  rm -rf HackGenNerd*
fi

# nodeのインストール

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

mkdir -p ~/.local/bin
npm config set prefix=$HOME/.local

npm install npm -g
npm install yarn -g
npm install pnpm -g

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
GO_VER=1.17.2
wget https://golang.org/dl/go${GO_VER}.linux-amd64.tar.gz
if [ -d /usr/local/go ]; then
   sudo rm -rf /usr/local/go
fi
sudo tar -C /usr/local -xzf go${GO_VER}.linux-amd64.tar.gz
rm go${GO_VER}.linux-amd64.tar.gz

# vimのインストール
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y vim neovim
ln -s ~/dotfiles/nvim ~/.config/nvim

# その他のapp
~/.cargo/bin/cargo install exa
~/.cargo/bin/cargo install bat
~/.cargo/bin/cargo install cargo-update

/usr/local/go/bin/go get github.com/jesseduffield/lazygit
mkdir -p ~/.config/jesseduffield/lazygit
ln -s ~/dotfiles/lazygit/config.yml ~/.config/jesseduffield/lazygit/config.yml

