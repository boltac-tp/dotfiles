#!/bin/bash

deno upgrade
pyenv update
poetry self update
pipx upgrade-all
sheldon lock --update
curl https://get.volta.sh | bash -s -- --skip-setup
npm-check -u -g

~/dotfiles/scripts/install_go.sh
rustup update
cargo install-update -a
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/cmd/godoc@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/jesseduffield/lazygit@latest
go install github.com/jesseduffield/lazydocker@latest
go install mvdan.cc/sh/v3/cmd/shfmt@latest

go install -tags extended github.com/gohugoio/hugo@latest
