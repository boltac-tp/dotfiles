ミラーサーバ更新
```
sudo pacman-mirrors --fasttrack && sudo pacman -Syy
```
ディレクトリ名の変更
```
sudo pacman -Sy xdg-user-dirs-gtk
LANC=C xdg-user-dirs-gtk-update
```
日本語環境
```
sudo pacman -S fcitx5 fcitx5-mozc fcitx5-qt
```
~/.profileへ追記
```
export GTK_IM_MODULE=fcitx5
export XMODIFIERS=@im-fcitx
export QT_IM_MODULE=fcitx
```
よくわからないけど、これでうまくいった
```
sudo pacman -S manjaro-asian-input-support-fcitx5
```
gcc
```
sudo pacman -S pkgconf gcc
```
git
```
sudo pacman -S git
```
yay
```
$ git clone https://aur.archlinux.org/yay-bin.git yay-bin
$ cd yay-bin
$ makepkg -si --noconfirm
$ cd ..
$ rm -rf yay-bin #任意
```
vscode
```
yay -S visual-studio-code-bin
```
zsh
```
mkdir ~/.zsh
ln -s ~/dotfiles/.zshenv ~/.zshenv
ln -s ~/dotfiles/.zshrc ~/.zsh/.zshrc
ln -s ~/dotfiles/.zlogin ~/.zsh/.zlogin
ln -s ~/dotfiles/.zimrc ~/.zsh/.zimrc
sudo pacman -Sy shellcheck
```
node
```
sudo pacman -S nodejs
sudo pacman -S npm
```
python
```
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python3 - 
~/.local/bin/poetry config virtualenvs.in-project true
```
rust
```
curl https://sh.rustup.rs -sSf | sh -s -- -y
```
go
```
GO_VER=`git ls-remote https://github.com/golang/go | grep refs/tags | grep -oE "[0-9]\.[0-9][0-9]?\.[0-9][0-9]?" | sort --version-sort | tail -n 1`
wget -q https://golang.org/dl/go${GO_VER}.linux-amd64.tar.gz
if [ -d /usr/local/go ]; then
   sudo rm -rf /usr/local/go
fi
sudo tar -C /usr/local -xzf go${GO_VER}.linux-amd64.tar.gz
rm go${GO_VER}.linux-amd64.tar.gz
```
neovim
```
sudo pacman -S neovim
ln -s ~/dotfiles/nvim ~/.config/nvim
```

その他のapp
```
~/.cargo/bin/cargo install exa bat cargo-update cargo-edit

/usr/local/go/bin/go get github.com/jesseduffield/lazygit
mkdir -p ~/.config/jesseduffield/lazygit
ln -s ~/dotfiles/lazygit/config.yml ~/.config/jesseduffield/lazygit/config.yml
```
