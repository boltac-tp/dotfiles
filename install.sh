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

echo $MY_ENV
sudo sed -i.bak -r 's!http://(security|us.archive).ubuntu.com/ubuntu!http://ftp.riken.jp/Linux/ubuntu!' /etc/apt/sources.list
sudo apt update && sudo apt upgrade -y

if [[ $MY_ENV = GNOME ]] || [[ $MY_ENV = KDE ]]; then
  sudo apt remove --purge "libreoffice*" -y

  sudo apt install -y remmina remmina-plugin-rdp
  
  sudo add-apt-repository ppa:solaar-unifying/stable -y
  sudo apt update
  sudo apt install -y solaar

  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg

  sudo apt install -y apt-transport-https
  sudo apt update
  sudo apt install -y code

  if [[ $MY_ENV = GNOME ]]; then
    # script for Ubuntu
    LANG=C xdg-user-dirs-gtk-update
    sudo snap remove --purge firefox -y
    sudo apt install -y keepassxc gnome-tweaks firefox
  elif [[ $MY_ENV = KDE ]]; then
    # script for Kubuntu
    sudo apt install -y xdg-user-dirs gnome-keyring
    LANG=C xdg-user-dirs-update --force
  fi
fi

# install some dev dependency
sudo apt install -y unzip cmake curl pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev libssl-dev
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

# install : some fonts
HACK_GEN_NERD_VER=$(git ls-remote https://github.com/yuru7/HackGen | grep refs/tags | grep -oE "v[0-9]\.[0-9][0-9]?\.[0-9][0-9]?" | sort --version-sort | tail -n 1)
PLEMOL_NERD_VER=$(git ls-remote https://github.com/yuru7/Plemoljp | grep refs/tags | grep -oE "v[0-9]\.[0-9][0-9]?\.[0-9][0-9]?" | sort --version-sort | tail -n 1)
if [[ $MY_ENV != WSL ]]; then
  wget -q https://github.com/yuru7/HackGen/releases/download/"${HACK_GEN_NERD_VER}"/HackGenNerd_"${HACK_GEN_NERD_VER}".zip
  unzip HackGenNerd_"${HACK_GEN_NERD_VER}".zip
  sudo cp HackGenNerd_"${HACK_GEN_NERD_VER}"/HackGenNerdConsole* /usr/local/share/fonts
  rm -rf HackGenNerd*
  wget -q https://github.com/yuru7/PlemolJP/releases/download/"${PLEMOL_NERD_VER}"/PlemolJP_"${PLEMOL_NERD_VER}".zip
  unzip PlemolJP_"${PLEMOL_NERD_VER}".zip
  sudo cp PlemolJP_"${PLEMOL_NERD_VER}"/PlemolJPConsole/PlemolJPConsole* /usr/local/share/fonts
  rm -rf PlemolJP*
fi

# install : node
curl https://get.volta.sh | bash -s -- --skip-setup
~/.volta/bin/volta install node@16

# install : deno
curl -fsSL https://deno.land/install.sh | sh

# install : python
sudo apt install -y python3-venv python3-pip
curl -sSL https://install.python-poetry.org | python3 - 
~/.local/bin/poetry config virtualenvs.in-project true
python3 -m pip install --user pipx
pipx install pre-commit
# install : rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

# install : go
GO_VER=$(git ls-remote https://github.com/golang/go | grep refs/tags | grep -oE "[0-9]\.[0-9]??[0-9]?\.[0-9]??[0-9]?" | sort --version-sort | tail -n 1)
if [ -d /usr/local/go ]; then
   sudo rm -rf /usr/local/go
fi
curl -L https://go.dev/dl/go"${GO_VER}".lunux-amd64.tar.gz | sudo tar -C /usr/local -xzf go"${GO_VER}".linux-amd64.tar.gz

# install : vim
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update && sudo apt install -y vim neovim
ln -s ~/dotfiles/nvim ~/.config/nvim

# install : docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker "${USER}"

# その他のapp
/usr/local/go/bin/go install github.com/jesseduffield/lazygit@latest
/usr/local/go/bin/go install golang.org/x/tools/cmd/goimports@latest
~/.cargo/bin/cargo install exa bat cargo-update cargo-edit cargo-compete sheldon ripgrep
~/.cargo/bin/cargo install starship --locked

# sheldon setting
mkdir -p ~/.sheldon
mkdir -p ~/.config/sheldon
ln -s ~/dotfiles/sheldon/plugins.toml ~/.sheldon/plugins.toml
ln -s ~/dotfiles/sheldon/plugins.toml ~/.config/sheldon/plugins.toml

