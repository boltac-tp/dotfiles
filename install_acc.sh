#!bin/bash

pip3 install --user online-judge-tools
npm install -g atcoder-cli

mkdir -p ~/.config/atcoder-cli-nodejs

ln -s ~/dotfiles/atcoder-cli-nodejs/python3 ~/.config/atcoder-cli-nodejs/python3
ln -s ~/dotfiles/atcoder-cli-nodejs/ts ~/.config/atcoder-cli-nodejs/ts
