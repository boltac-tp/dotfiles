#!/usr/bin/bash

sudo apt update
sudo apt upgrade -y

sudo apt install curl

~/dotfiles/scripts/_zsh.sh
~/dotfiles/scripts/_git.sh
~/dotfiles/scripts/_node.sh
~/dotfiles/scripts/_python.sh
~/dotfiles/scripts/_vim.sh
~/dotfiles/scripts/_rust.sh
~/dotfiles/scripts/_app.sh
