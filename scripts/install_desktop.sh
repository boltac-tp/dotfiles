#!/bin/bash

sudo apt remove --purge "libreoffice*" -y

# install flatpak
sudo apt -y install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install xsel
sudo apt -y install xsel

# install remmina
sudo apt install -y remmina remmina-plugin-rdp

# install solaar
sudo add-apt-repository ppa:solaar-unifying/stable -y
sudo apt update
sudo apt install -y solaar

# install keepassxc
sudo apt install -y keepassxc

# install visial studio code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code

# install desktop tools
if [[ $MY_ENV = GNOME ]]; then
  # for Ubuntu
  LANG=C xdg-user-dirs-gtk-update
  sudo apt install -y gnome-tweaks
elif [[ $MY_ENV = KDE ]]; then
  #  for Kubuntu
  sudo apt install -y xdg-user-dirs gnome-keyring
  LANG=C xdg-user-dirs-update --force
fi

# install fonts
HACK_GEN_NERD_VER=$(git ls-remote https://github.com/yuru7/HackGen | grep refs/tags | grep -oE "v[0-9]\.[0-9][0-9]?\.[0-9][0-9]?" | sort --version-sort | tail -n 1)
PLEMOL_NERD_VER=$(git ls-remote https://github.com/yuru7/Plemoljp | grep refs/tags | grep -oE "v[0-9]\.[0-9][0-9]?\.[0-9][0-9]?" | sort --version-sort | tail -n 1)
wget -q https://github.com/yuru7/HackGen/releases/download/"${HACK_GEN_NERD_VER}"/HackGenNerd_"${HACK_GEN_NERD_VER}".zip
unzip HackGenNerd_"${HACK_GEN_NERD_VER}".zip
sudo cp HackGenNerd_"${HACK_GEN_NERD_VER}"/HackGenNerdConsole* /usr/local/share/fonts
rm -rf HackGenNerd*
wget -q https://github.com/yuru7/PlemolJP/releases/download/"${PLEMOL_NERD_VER}"/PlemolJP_"${PLEMOL_NERD_VER}".zip
unzip PlemolJP_"${PLEMOL_NERD_VER}".zip
sudo cp PlemolJP_"${PLEMOL_NERD_VER}"/PlemolJPConsole/PlemolJPConsole* /usr/local/share/fonts
rm -rf PlemolJP*

# install wine
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$(lsb_release -cs)/winehq-$(lsb_release -cs).sources
sudo apt update
sudo apt install -y --install-recommends winehq-stable
sudo apt install -y playonlinux q4wine


