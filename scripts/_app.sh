#!/usr/bin/bash

#install apps
echo '\n install apps\n \n'

~/.cargo/bin/cargo install exa
sudo apt update
sudo apt install bat -y

ln -s /usr/bin/batcat ~/.local/bin/bat
