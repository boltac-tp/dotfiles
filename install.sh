#!bin/bash

sudo apt update
sudo apt install zsh
chsh -s $(which zsh)

sudo apt update
sudo apt install vim

sudo apt update
sudo apt install neovim

sudo add-apt-repository ppa:gitcore/ppa
sudo apt update
sudo apt install git

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
