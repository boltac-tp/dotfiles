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

ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
