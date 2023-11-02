#!/bin/bash

sheldon lock --update

deno upgrade
curl https://get.volta.sh | bash -s -- --skip-setup
volta install node

pipx upgrade-all
rye self update

npm-check -u -g

~/dotfiles/scripts/install_go.sh

rustup update
cargo install-update -a
gup update
