#!bin/bash

sudo apt update
sudo apt upgrade -y

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install -y git

sudo add-apt-repository ppa:lazygit-team/release -y
sudo apt update
sudo apt install -y lazygit

sudo apt install -y zsh
sudo apt install -y vim neovim cmake

# install node

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

mkdir -p ~/.local/bin
npm config set prefix=$HOME/.local

npm install npm -g
npm install yarn -g

# install python

curl https://pyenv.run | bash
exec $SHELL

sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl

pyenv install 3.9.0
pyenv install anaconda3-2020.07

pip3 install --user python-language-server

curl https://sh.rustup.rs -sSf | sh -s -- -y

#install apps
~/.cargo/bin/cargo install exa
sudo apt update
sudo apt install bat -y

mkdir -p ~/.config/jesseduffield/lazygit
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s /usr/bin/batcat ~/.local/bin/bat
ln -s ~/dotfiles/lazygit/config.yml ~/.config/jesseduffield/lazygit/config.yml
ln -s ~/dotfiles/.jupyter ~/.jupyter

sudo chsh -s $(which zsh) $(whoami)
