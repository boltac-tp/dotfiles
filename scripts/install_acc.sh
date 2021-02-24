#!/usr/bin/bash

# install atcoder - cli
pip3 install --user online-judge-tools
npm install -g atcoder-cli

mkdir -p ~/.config/atcoder-cli-nodejs

ln -s ~/dotfiles/atcoder-cli-nodejs/python3 ~/.config/atcoder-cli-nodejs/python3
ln -s ~/dotfiles/atcoder-cli-nodejs/ts ~/.config/atcoder-cli-nodejs/ts

#install cargo-compete
sudo apt install pkg-check
cargo install cargo-compete

