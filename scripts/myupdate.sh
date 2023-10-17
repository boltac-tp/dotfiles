#!/bin/bash

deno upgrade
pipx upgrade-all
sheldon lock --update
curl https://get.volta.sh | bash -s -- --skip-setup
npm-check -u -g
rye self update

~/dotfiles/scripts/install_go.sh

rustup update
cargo install-update -a
gup update
