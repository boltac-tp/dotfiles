#!/usr/bin/bash
echo '\n install git&utils \n \n'

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install -y git

sudo add-apt-repository ppa:lazygit-team/release -y
sudo apt update
sudo apt install -y lazygit

mkdir -p ~/.config/jesseduffield/lazygit
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/lazygit/config.yml ~/.config/jesseduffield/lazygit/config.yml
