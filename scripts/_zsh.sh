#!/usr/bin/bash
echo '\n install zsh\n \n'

sudo apt install -y zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zprofile ~/.zprofile
sudo chsh -s $(which zsh) $(whoami)

sudo apt update
sudo apt install -y openssh-client socat
