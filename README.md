## SSH key generate

```bash
ssh-keygen -t rsa
```

## Commit Message

- chore : タスクファイルなどプロダクションに関係ない修正
- docs : ドキュメントの更新
- feat : ユーザ向け新機能や変更
- change : 仕様変更による機能変更
- update : 機能追加がない修正
- fix : ユーザ向けの不具合修正
- hotfix : クリティカルな不具合修正
- add : 機能追加を含まないファイルの追加
- refactor : リファクタリング
- improve : コードの改善
- remove : ファイルの削除
- revert : コミットのrevert
- style : フォーマットなどスタイル
- test : テストコードの追加や修正

## Ubuntu

手動でインストールするもの Kubuntu KDE Plasma のアップデート

```bash
sudo add-apt-repository ppa:kubuntu-ppa/backports
sudo apt full-upgrade
```

## WSL

install script

## WSL Arch のインストール

[link](thhps://archlinux.org/download/)からbootstrapイメージをダウンロード  
tarballを展開し`etc/pacman.d/mirrorlist`の適当なミラーサーバをコメントアウトの解除  
gzipで再度圧縮
```bash
wget (tarball url)
sudo tar xzvf ~~.tar.gz
# /etc/pacman.d/mirrolist の編集
sudo tar czvf ~~.tar.gz *
```
wslへインポート
```power shell
wsl --import ArchLinux c:\wsl\qrch c:\~~.tar.gz
```
ユーザの設定
```bash
pacman-key --init
pacman-key --populate archlinux

pacman -Syyu base base-devel git vim wget reflector zsh openssl
pacman -Syy
export EDITOR="$(which vim)"
reflector --country Japan --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

#rootのパスを設定
passwd
#ユーザの追加
useradd -m -G wheel -s /bin/zsh -d /home/{USENAME} {USERNAME}
passwd {USERNAME}

#wheelユーザーグループにsudoer(%wheel ALL=(ALL:ALL)をコメントアウトの解除)
sudoedit /etc/sudoers
```
WSLデフォルトユーザ
`etc/wsl.conf`に以下を記載
```
[user]
default={USERNAME}
```
systemdを使うので以下も
```
[boot]
systemd=true
```
## Windows

[link](https://github.com/boltac-tp/dotfiles/blob/master/docs/install_win11.md)

## Arch/Manjaro/xcfe

[link](https://github.com/boltac-tp/dotfiles/blob/master/docs/install_arch_manjaro.md)
