#!/bin/bash

source ~/dotfiles/zsh/.zshenv

echo "${MY_ENV}"

mkdir -p "${XDG_CONFIG_HOME}"
mkdir -p "${XDG_CACHE_HOME}"
mkdir -p "${XDG_DATA_HOME}"
mkdir -p "${XDG_STATE_HOME}"
mkdir -p "${HOME}/.local/bin"
mkdir -p "${HOME}/.local/src"

# install yay
git clone https://aur.archlinux.org/yay-bin.git yay-bin
cd yay-bin
makepkg -si --noconfirm
cd ..
rm -rf yay-bin

# install some dependency
yay -S unzip keychain --noconfirm
# for Scipy
yay -S gcc-fortran openblas --noconfirm
# for shapely
yay -S geos --noconfirm

# install:zsh
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/.zshenv ~/.zshenv
ln -s ~/dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
yay -S shellchec --noconfirmk

#install:git
ln -s ~/dotfiles/git/ ~/.config/git
yay -S github-cl --noconfirmi

# install neovim
yay -S neovim-nightly-bin --noconfirm
ln -s ~/dotfiles/nvim ~/.config/nvim

# install docker
yay -S docker docker-compose --noconfirm
sudo usermod -aG docker "${USER}"
sudo systemctl start docker

#install:node
curl https://get.volta.sh | bash
volta install node

#install:deno
curl -fsSL https://deno.land/install.sh | sh

#install direnv
curl -sfL https://direnv.net/install.sh | bash
ln -s ~/dotfiles/direnv ~/.config/direnv

#install:python
yay -S python-pipx --noconfirm
pipx install ruff ruff-lsp pyright
ln -s ~/dotfiles/ruff ~/.config/ruff
yay -S uv --noconfirm
curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
rye config --set-bool behavior.use-uv=true

#install:rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

# install : go
~/dotfiles/scripts/install_go.sh

# other app
pipx install pre-commit tldr

echo "gup"
go install github.com/nao1215/gup@latest
echo "gopls"
go install golang.org/x/tools/gopls@latest
echo "golangci"
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
echo "golangci-lint"
go install github.com/nametake/golangci-lint-langserver@latest
echo "goimports"
go install golang.org/x/tools/cmd/goimports@latest
echo "godoc"
go install golang.org/x/tools/cmd/godoc@latest
echo "lazygit"
go install github.com/jesseduffield/lazygit@latest
echo "lazydocker"
go install github.com/jesseduffield/lazydocker@latest
echo "shfmt"
go install mvdan.cc/sh/v3/cmd/shfmt@latest
echo "hugo"
go install -tags extended github.com/gohugoio/hugo@latest

rustup component add rust-analyzer
cargo install eza bat cargo-update cargo-edit cargo-compete sheldon ripgrep stylua

npm install -g typescript-language-server typescript
npm install -g eslint_d
npm install -g npm-check
npm install -g @biomejs/biome

# sheldon setting
ln -s ~/dotfiles/sheldon ~/.config/sheldon

# for atcoder
rustup install 1.70.0
pipx install online-judge-tools
npm install -g atcoder-cli

acc config-dir
acc config default-template python
acc config default-test-dirname-format test
acc config default-task-choice all
mkdir -p ~/.config/atcoder-cli-nodejs/python
ln -s ~/dotfiles/atcoder-cli/template.json ~/.config/atcoder-cli-nodejs/python/template.json
cp ~/dotfiles/atcoder-cli/main.py ~/.config/atcoder-cli-nodejs/python/main.py
