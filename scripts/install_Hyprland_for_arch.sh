# GUI librualy
paru --noconfirm -S qt5-wayland qt6-wayland xorg-xwayland

# hyprland
ln -s ~/dotfiles/hypr ~/.config/hypr
paru --noconfirm -S --devel hyprland
paru --noconfirm -S hyprlock
paru --noconfirm -S hyprpaper
# font
paru -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-cica ttf-nerd-fonts-symbols ttf-font-awesome ttf-roboto ttf-sarasa-gothic-sc --noconfirm
./install_fonts.sh

# ime
paru --noconfirm -S fcitx5-im fcitx5-mozc

# pipewire
paru --noconfirm -S pipewire pipewire-pulse

# 通知サービス
ln -s ~/dotfiles/mako ~/.config/mako
paru --noconfirm -S mako

# status bar
kn -s ~/dotfiles/waybar ~/.config/waybar
paru --noconfirm -S waybar

# ランチャ
paru --noconfirm -S wofi

# terminal
ln -s ~/dotfiles/kitty ~/.config/kitty
paru --noconfirm -S kitty

# clipboard
paru --noconfirm -S cliphist

# snapshot
paru --noconfirm -S grim blast

# logout
ln -s ~/dotfiles/wlogout ~/.config/wlogout
paru --noconfirm -S wlogout

# bluetooth
# https://github.com/bluez/bluez
# デーモンスタート
# systemctl enable --now bluetooth.service
# bluetoolthctlコマンドによる設定 or
# bluetuiを使って設定
paru --noconfirm -S bluez bluez-utils bluetui

# file manager
paru --noconfirm -S thunar gvfs gvfs-smb thmbler ffmpegthumbnailer

# network manager applet
paru --noconfirm -S network-manager-applet

# firewall
paru --noconfirm -S ufw

# browser
paru --noconfirm -S firefox microsoft-edge-dev-bin

# login
# https://wiki.archlinux.jp/index.php/Greetd
# を参考に
paru --noconfirm -S greetd-tuigreet
# gnome-keyring
# https://wiki.archlinux.jp/index.php/GNOME/Keyring
# を参考に
paru --noconfirm -S gnome-keyring seahorse libsecret

# mailer
paru --noconfirm -S thunderbird

# dropbox
paru --noconfirm -S dropbox thaunar-dropbox

# keepass
paru --noconfirm -S keepassxc

# pdf e-pub zip_archive reader
paru --noconfirm -S rar unrar apvlv thorium-reader-bin mcomix

# media
paru --noconfirm -S mpv mpd ymuse
lm -s ~/dotfiles/mpd ~/.config/mpd
systemctl --user start mpd
systemctl --user enable mpd

# samba
# ~/.local/credentials/shareファイルを作ること
paru --noconfirm -S sambaclient
sudo mkdir -p /mnt/Music
echo "//192.168.10.21/Music /mnt/Music cifs _netdev,x-systemd.automount,credentials=/home/boltac/.config/credentials/share 0 0" | sudo tee -a /etc/fstab

# remmina
paru --noconfirm -S remmina freerdp
# Note:If one protocols is not available in the Remmina dropdown menu after installing the required package, make sure to completely quit Remmina first; run killall remmina.
# When you restart Reemmina, the protocol should be available.

# nordvpn
# https://support.nordvpn.com/hc/en-us/articles/20196094470929-Installing-NordVPN-on-Linux-distributions
paru --noconfirm -S nordvpn-bin
sudo systemctl enable nordvpnd.service
sudo systemctl start nordvpnd.service
sudo usermod -aG nordvpn $USER
