#!/usr/bin/bash
echo '\n install zsh\n \n'

sudo apt install -y zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc
sudo chsh -s $(which zsh) $(whoami)
