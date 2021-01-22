#!/usr/bin/bash

sudo apt update
sudo apt upgrade -y

~/dotfiles/scripts/install_zsh.sh
~/dotfiles/scripts/install_git.sh
~/dotfiles/scripts/install_node.sh
~/dotfiles/scripts/install_python.sh
~/dotfiles/scripts/install_vim.sh
~/dotfiles/scripts/install_rust.sh
~/dotfiles/scripts/install_app.sh
