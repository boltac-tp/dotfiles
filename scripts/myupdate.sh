#!/bin/bash

if [ "${DIST}" == 'Arch Linux' ]; then
	yay --noconfirm
fi

echo ''
printf "\e[94m%s\e[m\n" "neovim"
echo ''

~/dotfiles/scripts/install_neovim_head.sh

echo ''
printf "\e[94m%s\e[m\n" "zsh plugins"
echo ''
sheldon lock --update

echo ''
printf "\e[94m%s\e[m\n" "deno"
echo ''
deno upgrade

echo ''
printf "\e[94m%s\e[m\n" "bun"
echo ''
bun upgrade

echo ''
printf "\e[94m%s\e[m\n" "npm app"
echo ''
bun update -g

echo ''
printf "\e[94m%s\e[m\n" "python app"
echo ''
rye self update
pipx upgrade-all

echo ''
printf "\e[94m%s\e[m\n" "go & go app"
echo ''
~/dotfiles/scripts/install_go.sh
gup update

echo ''
printf "\e[94m%s\e[m\n" "rust & rust app"
echo ''
rustup update
cargo install-update -a
