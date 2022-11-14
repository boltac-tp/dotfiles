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

echo $MY_ENV
sudo sed -i.bak -r 's!http://(security|us.archive).ubuntu.com/ubuntu!http://ftp.riken.jp/Linux/ubuntu!' /etc/apt/sources.list
sudo apt update && sudo apt upgrade -y

# install some dev dependency
sudo apt install -y unzip cmake curl pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev libssl-dev libyaml-dev
# install dependency for pyenv
sudo apt update
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

mkdir ~/.config

# install : zsh
sudo apt install -y zsh
mkdir ~/.zsh
ln -s ~/dotfiles/.zsh/.zshenv ~/.zshenv
ln -s ~/dotfiles/.zsh/.zshrc ~/.zsh/.zshrc
ln -s ~/dotfiles/.zsh/.zlogin ~/.zsh/.zlogin
on -s ~/dotfiles/.zsh/completions ~/.zsh/completions
sudo apt install -y shellcheck

sudo chsh -s "$(which zsh)" "$(whoami)"
sudo apt install -y openssh-client socat keychain

# install : tmux
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
sudo apt install -y tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install : git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update && sudo apt install -y git
ln -s ~/dotfiles/.gitconfig ~/.gitconfig

# install : node
curl https://get.volta.sh | bash -s -- --skip-setup
~/.volta/bin/volta install node@16

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

# install : rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

# install : go
LATEST_GO_VER=$(git ls-remote https://github.com/golang/go | grep refs/tags | grep -oE "[0-9]\.[0-9]??[0-9]?\.[0-9]??[0-9]?" | sort --version-sort | tail -n 1)
curl -L https://go.dev/dl/go"${LATEST_GO_VER}".lunux-amd64.tar.gz | sudo tar xzf - -C /usr/local -xzf

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

# その他のapp
/usr/local/go/bin/go install github.com/jesseduffield/lazygit@latest
/usr/local/go/bin/go install golang.org/x/tools/cmd/goimports@latest
/usr/local/go/bin/go install golang.org/x/tools/cmd/godoc@latest
~/.cargo/bin/cargo install exa bat cargo-update cargo-edit cargo-compete sheldon ripgrep
~/.cargo/bin/cargo install starship --locked

# sheldon setting
mkdir -p ~/.sheldon
mkdir -p ~/.config/sheldon
ln -s ~/dotfiles/sheldon/plugins.toml ~/.sheldon/plugins.toml
ln -s ~/dotfiles/sheldon/plugins.toml ~/.config/sheldon/plugins.toml

if [[ $MY_ENV != WSL ]]; then
    ~/dotfiles/scripts/install_desktop.sh
fi

# for atcoder
~/.cargo/bin/rustup install 1.42.0
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
