# GUI librualy
yay -S qt5-wayland qt6-wayland xorg-xwayland

# hyprland
ln -s ~/dotfiles/hypr ~/.config/hypr
yay -S --devel hyprland
yay -S hyprlock

# font
yay -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-hackgen ttf-cica ttf-nerd-fonts-symbols ttf-font-awesome

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
yay -S gnome-keyring libsecret

# mailer
# desktopエントリを$XDG_DATA_HOME/applications/にコピー、Exec行に引数を。
# Exec=mailspring -password-store=gnome-libsecret %u
yay -S mailspring

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
