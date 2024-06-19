#!/bin/bash

# archのとき、scripts前に
# pacman -Syyu base base-devel git vim wget reflector zsh
# はインストールしておく

source ~/dotfiles/zsh/.zshenv

DIST=$(grep -e ^NAME= /etc/os-release | sed -e s/NAME=// -e s/\"//g)
echo "${MY_ENV} ${DIST}"
isUbuntu=false
isArch=false
if [ "${DIST}" == Ubuntu ]; then
	isUbuntu=true
fi
if [ "${DIST}" == 'Arch Linux' ]; then
	isArch=true
fi

mkdir -p "${XDG_CONFIG_HOME}"
mkdir -p "${XDG_CACHE_HOME}"
mkdir -p "${XDG_DATA_HOME}"
mkdir -p "${XDG_STATE_HOME}"
mkdir -p "${HOME}/.local/bin"
mkdir -p "${HOME}/.local/src"

# install yay
# https://github.com/jquer/yqy

if "${isArch}"; then
	git clone https://aur.archlinux.org/yay-bin.git yay-bin
	(
		cd yay-bin || exit
		makepkg -si --noconfirm
		cd ..
	)
	rm -rf yay-bin
fi

# install some dependency
if "${isArch}"; then
	yay -S unzip keychain less man-db pkgfile time lldb --noconfirm
	# for Scipy
	yay -S gcc-fortran openblas --noconfirm
	# for shapely
	yay -S geos --noconfirm
fi

if "${isUbuntu}"; then
	sudo sed -i.bak -r 's!http://(security|us.archive).ubuntu.com/ubuntu!http://ftp.riken.jp/Linux/ubuntu!' /etc/apt/sources.list
	sudo apt -qq update && sudo apt -qq upgrade -y
	sudo apt -qq install -y unzip make cmake curl pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev libssl-dev libyaml-dev
	# install dependency for scipy
	sudo apt -qq install -y gcc g++ gfortran libopenblas-dev liblapack-dev pkg-config python3-pip python3-dev
	# install dependency for shapely
	sudo apt -qq install -y libgeos-dev
fi

# install wslu
if "${isArch}"; then
	wget https://pkg.wslutiliti.es/public.key
	sudo pacman-key --add public.key
	sudo pacman-key --lsign-key 2D4C887EB08424F157151C493DD50AA7E055D853
	if grep -e wslutilities /etc/pacman.conf; then
		:
	else
		echo "[wslutilities]" | sudo tee -a /etc/pacman.conf
		echo "Server = https://pkg.wslutiliti.es/arch/" | sudo tee -a /etc/pacman.conf
	fi
	yay -Sy && yay -S --noconfirm wslu
fi

if "${isUbuntu}"; then
	sudo add-apt-repository ppa:wslutilities/wslu
	sudo apt update
	sudo apt install wslu
fi

# install:zsh
mkdir -p ~/.local/share/zsh
ln -s ~/dotfiles/zsh/.zshenv ~/.zshenv
ln -s ~/dotfiles/zsh ~/.config/zsh

if "${isArch}"; then
	yay -S shellcheck --noconfirm
fi

if "${isUbuntu}"; then
	sudo apt -qq install -y zsh shellcheck
	sudo chsh -s "$(which zsh)" "$(whoami)"
fi

#install:git
# https://git-scm.com/
# https://cli.github.com/
ln -s ~/dotfiles/git/ ~/.config/git
if "${isArch}"; then
	yay -S github-cli --noconfirm
fi
if "${isUbuntu}"; then
	sudo add-apt-repository ppa:git-core/ppa -y
	sudo apt -qq update && sudo apt -qq install -y git

	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
		sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
		sudo apt update &&
		sudo apt install gh -y
fi

# install neovim
# https://github.com/neovim/neovim

~/dotfiles/scripts/install_neovim_head.sh
ln -s ~/dotfiles/nvim ~/.config/nvim

# install docker
# https://docs.docker.com

if "${isArch}"; then
	yay -S docker docker-compose --noconfirm
fi
if "${isUbuntu}"; then
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

	sudo apt -qq update && sudo apt -qq install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi
sudo usermod -aG docker "${USER}"
sudo systemctl start docker

# install node
if "${isArch}"; then
	yay -S nodejs-lts-iron npm --noconfirm
else
	sudo apt install nodejs
fi
ln -s ~/dotfiles/npm ~/.config/npm

#install:deno
# https://deno.com
curl -fsSL https://deno.land/install.sh | sh

#install:bun
# https://bun.sh
curl -fsSL https://bun.sh/install | bash

#install direnv
# https://github.com/direnv/direnv
curl -sfL https://direnv.net/install.sh | bash
ln -s ~/dotfiles/direnv ~/.config/direnv

#install:python
# https://github.com/pypa/pipx
if "${isArch}"; then
	yay -S python-pipx --noconfirm
fi
if "${isUbuntu}"; then
	python3 -m pip install --user pipx
fi
# https://github.com/astral-sh/uv
# https://github.com/astral-sh/ruff
# https://github.com/astral-sh/rye
pipx install uv ruff ruff-lsp pyright
ln -s ~/dotfiles/ruff ~/.config/ruff

curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
mkdir -p ~/.config/rye
ln -s ~/dotfiles/rye/config.toml ~/.config/rye/config.toml

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
cargo install eza bat cargo-update cargo-edit cargo-compete sheldon ripgrep stylua fd-find

bun install -g typescript-language-server typescript @biomejs/biome

# sheldon setting
ln -s ~/dotfiles/sheldon ~/.config/sheldon

# for atcoder
rustup install 1.70.0
pipx install online-judge-tools
bun install -g atcoder-cli

acc config-dir
acc config default-template python
acc config default-test-dirname-format test
acc config default-task-choice all
mkdir -p ~/.config/atcoder-cli-nodejs/python
ln -s ~/dotfiles/atcoder-cli/template.json ~/.config/atcoder-cli-nodejs/python/template.json
cp ~/dotfiles/atcoder-cli/main.py ~/.config/atcoder-cli-nodejs/python/main.py
