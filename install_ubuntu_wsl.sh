#!/bin/bash

# 利用環境の特定
if [[ "$(uname)" = 'Linux' ]] && [[ $(pgrep -c gnome-panel) -gt 0 ]]; then
  MY_ENV=GNOME
elif [[ "$(uname)" = 'Linux' ]] && [[ $(pgrep -c plasmashell) -gt 0 ]]; then
  MY_ENV=KDE
elif [[ "$(uname -r)" = *microsoft* ]]; then
  MY_ENV=WSL
else
  MY_ENV=Windows
fi

export MY_ENV

mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/.cache"
mkdir -p "${HOME}/.local/share"
mkdir -p "${HOME}/.local/bin"
mkdir -p "${HOME}/.local/src"

mkdir -p "${HOME}/.local/share/cargo"
mkdir -p "${HOME}/.local/share/pyenv"

echo $MY_ENV
sudo sed -i.bak -r 's!http://(security|us.archive).ubuntu.com/ubuntu!http://ftp.riken.jp/Linux/ubuntu!' /etc/apt/sources.list
sudo apt update && sudo apt upgrade -y

# install some dev dependency
sudo apt install -y unzip make cmake curl pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev libssl-dev libyaml-dev
# install dependency for pyenv
sudo apt update
sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# install : zsh
sudo apt install -y zsh
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
sudo apt install -y shellcheck
sudo chsh -s "$(which zsh)" "$(whoami)"

sudo apt install -y openssh-client socat keychain

# install : tmux
#ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
#sudo apt install -y tmux
#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install : git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update && sudo apt install -y git
ln -s ~/dotfiles/git ~/.config/git

# install : node
curl https://get.volta.sh | bash -s -- --skip-setup
~/.volta/bin/volta install node

# install : deno
curl -fsSL https://deno.land/install.sh | sh

# install : python
sudo apt install -y python3-venv python3-pip

# install : pyenv
curl https://pyenv.run | bash
~/.pyenv/bin/pyenv update

# install : poetry
curl -sSL https://install.python-poetry.org | python3 - 
~/.local/bin/poetry config virtualenvs.in-project true

# install : pipx
python3 -m pip install --user pipx
pipx install pre-commit

# install : ruff & black
pipx install ruff
pipx install ruff-lsp
pipx install black
ln -s ~/dotfiles/ruff ~/.config/ruff

# install : rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

# install : go
~/dotfiles/scripts/install_go.sh

# install : vim
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update && sudo apt install -y vim neovim
ln -s ~/dotfiles/nvim ~/.config/nvim

# install : docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker "${USER}"

# other app
pipx install tldr
/usr/local/go/bin/go install golang.org/x/tools/gopls@latest
/usr/local/go/bin/go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
/usr/local/go/bin/go install github.com/nametake/golangci-lint-langserver@latest
/usr/local/go/bin/go install golang.org/x/tools/cmd/goimports@latest
/usr/local/go/bin/go install golang.org/x/tools/cmd/godoc@latest
/usr/local/go/bin/go install github.com/jesseduffield/lazygit@latest
/usr/local/go/bin/go install github.com/jesseduffield/lazydocker@latest
/usr/local/go/bin/go install -tags extended github.com/gohugoio/hugo@latest

"${CARGO_HOME}/bin/rustup" run stable cargo install exa bat cargo-update cargo-edit cargo-compete sheldon ripgrep stylua
"${CARGO_HOME}/bin/rustup" run stable cargo install starship --locked

# sheldon setting
ln -s ~/dotfiles/sheldon ~/.config/sheldon

if [[ $MY_ENV != WSL ]]; then
    ~/dotfiles/scripts/install_desktop.sh
fi

# for atcoder
"${CARGO_HOME}/bin/rustup" install 1.42.0
~/.pyenv/bin/pyenv install 3.8.2
~/.pyenv/bin/pyenv install pypy3.6-7.2.0
pipx install online-judge-tools
npm install -g atcoder-cli

acc config-dir
acc config default-template python
acc config default-test-dirname-format test
acc config default-task-choice all
mkdir -p ~/.config/atcoder-cli-nodejs/python
ln -s ~/dotfiles/atcoder-cli/template.json ~/.config/atcoder-cli-nodejs/python/template.json
cp ~/dotfiles/atcoder-cli/main.py ~/.config/atcoder-cli-nodejs/python/main.py
