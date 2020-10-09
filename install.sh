#!bin/bash

sudo apt update
sudo apt upgrade -y

sudo apt install -y zsh
chsh -s $(which zsh)

sudo apt install -y vim

sudo apt install -y neovim

sudo add-apt-repository ppa:gitcore/ppa
sudo apt update
sudo apt install -y git

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

sudo apt update
sudo apt install -y python3-pip

sudo apt update
sudo apt install -y python3-venv

pip3 install --user python-language-server

sudo npm install -g yarn

curl https://sh.rustup.rs -sSf | sh -s --y

~/.cargo/bin/cargo install exa

sudo apt update
sudo apt install bat -y

mkdir ~/.config
mkdir ~/lab
mkdir ~/site
mkdir ~/develop
mkdir -p ~/.local/bin

ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/coc ~/.config/coc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.vimrc ~/.vimrc

ln -s /usr/bin/batcat ~/.local/bin/bat
