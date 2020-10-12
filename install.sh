#!bin/bash

sudo apt update
sudo apt upgrade -y

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install -y git

sudo apt install -y zsh
chsh -s $(which zsh)

sudo apt install -y vim neovim

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

mkdir -p ~/.local/bin
npm config set prefix=$HOME/.local

npm install npm -g

sudo apt update
sudo apt install -y python3-pip python3-venv

pip3 install --user python-language-server

curl https://sh.rustup.rs -sSf | sh -s -- -y

# install apps
mkdir ~/.source

~/.cargo/bin/cargo install exa

sudo apt update
sudo apt install bat -y

mkdir ~/.config
mkdir ~/lab
mkdir ~/site
mkdir ~/develop

ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/coc ~/.config/coc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.vimrc ~/.vimrc

ln -s /usr/bin/batcat ~/.local/bin/bat
