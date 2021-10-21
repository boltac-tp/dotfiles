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

  # install tmux
  sudo apt update
  sudo apt install tmux
  sudo apt install fcitx-mozc
fi

sudo apt update
sudo apt upgrade -y


# install some dev dependency
sudo apt install cmake curl pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev libssl-dev -y

# zshのインストール

sudo apt update
sudo apt install -y zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zprofile ~/.zprofile
sudo apt install -y shellcheck

sudo chsh -s $(which zsh) $(whoami)

sudo apt update
sudo apt install -y openssh-client socat

# gitのインストール

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install -y git

sudo add-apt-repository ppa:lazygit-team/release -y
sudo apt update
sudo apt install -y lazygit

mkdir -p ~/.config/jesseduffield/lazygit
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/lazygit/config.yml ~/.config/jesseduffield/lazygit/config.yml

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
sudo rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VER}.linux-amd64.tar.gz

# vimのインストール

sudo apt install -y vim neovim cmake
ln -s ~/dotfiles/nvim ~/.config/nvim

# その他のapp
~/.cargo/bin/cargo install exa
~/.cargo/bin/cargo install bat
~/.cargo/bin/cargo install cargo-update

