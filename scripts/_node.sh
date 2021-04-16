#!/usr/bin/bash

# install node
echo '\n install node.js & utils \n \n'

curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

mkdir -p ~/.local/bin
npm config set prefix=$HOME/.local

npm install npm -g
npm install yarn -g
npm install pnpm -g
