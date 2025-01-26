# GUI librualy
yay -S qt5-wayland qt6-wayland xorg-xwayland

# hyprland
ln -s ~/dotfiles/hypr ~/.config/hypr
yay -S --devel hyprland
yay -S hyprlock
yay -S hyprpaper
# font
paru -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-cica ttf-nerd-fonts-symbols ttf-font-awesome ttf-roboto ttf-sarasa-gothic-sc --noconfirm
./install_fonts.sh

# ime
yay -S fcitx5-im

# pipewire
yay -S pipewire pipewire-pulse

# 通知サービス
ln -s ~/dotfiles/mako ~/.config/mako
yay -S mako

# status bar
kn -s ~/dotfiles/waybar ~/.config/waybar
yay -S waybar

# ランチャ
yay -S wofi

# terminal
ln -s ~/dotfiles/kitty ~/.config/kitty
yay -S kitty

# clipboard
yay -S cliphist

# snapshot
yay -S grim blast

# logout
ln -s ~/dotfiles/wlogout ~/.config/wlogout
yay -S wlogout

# file manager
yay -S thunar gvfs gvfs-smb thmbler ffmpegthumbnailer

# network manager applet
yay -S network-manager-applet

# firewall
yay -S ufw

# browser
yay -S firefox microsoft-edge-dev-bin

# login
# https://wiki.archlinux.jp/index.php/Greetd
# を参考に
yay -S greetd-tuigreet
# gnome-keyring
# https://wiki.archlinux.jp/index.php/GNOME/Keyring
# を参考に
yay -S gnome-keyring seahorse libsecret

# mailer
yay -S thunderbird

# dropbox
yay -S dropbox thaunar-dropbox

# keepass
yay -S keepassxc

# pdf e-pub zip_archive reader
yay -S rar unrar apvlv thorium-reader-bin mcomix

# media
yay -S mpv mpd ymuse
lm -s ~/dotfiles/mpd ~/.config/mpd
systemctl --user start mpd
systemctl --user enable mpd

# samba
yay -S sambaclient
sudo mkdir -p /mnt/Music
echo "//192.168.10.21/Music /mnt/Music /mnt/Music cifs _netdev,noauto,x-systemd.automount,credentials=/home/boltac/credentials=/home/boltac/credentials/share 0 0" | sudo tee -a /etc/fstab

# remmina
yay -S remmina freerdp
# Note:If one protocols is not available in the Remmina dropdown menu after installing the required package, make sure to completely quit Remmina first; run killall remmina.
# When you restart Reemmina, the protocol should be available.
