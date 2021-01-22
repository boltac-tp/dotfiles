#!/usr/bin/bash

sudo apt install -y zsh

ln -s ~/dotfiles/.zshrc ~/.zshrc

sudo chsh -s $(which zsh) $(whoami)
