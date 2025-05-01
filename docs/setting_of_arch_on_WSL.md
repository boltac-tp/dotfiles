### パッケージミラーリスト、一般ユーザの設定
```
$ pacman-key --init
$ pacman-key --populate archlinux

$ pacman -Syyu base base-devel git vim wget reflector zsh
$ pacman -Syy
$ export EDITOR="$(which vim)"

$ reflector --country Japan --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# ルートユーザのパスワード設定
$ passwd

# ユーザの追加
$ useradd -m -G wheel -s /bin/zsh -d /home/USERNAME USERNAME
$ passwd USERNAME

# wheelユーザグループにsudoerの権限を付与
# `%wheel ALL=(ALL:ALL) ALL`のコメントアウトを解除する
$ sudoedit /etc/sudoers
```

### ロケールの設定
sudoedit /etc/locale.genで必要な行(en_US.UTF-8 UTF-8とかja_JP.UTF-8)のコメントアウトを解除、
```
$locale-gen
$echo LANG=en_US-UTG-8 > /etc/locale.conf
```


### デフォルトユーザの設定
/etc/wsl.confを
```
[user]
default=USERNAME
```

### /etc/wsl.conf
```
[boot]
systemd=true

[wsl2]
localhostFowwarding=true
memory=16GB
```

### windowspathをWSLに通す
winの~/.wslconfig
```
[interop]
appendWindowsPath = true
```

### wsl-utilsのインストール
```
$ wget https://pkg.wslutiliti.es/public.key
$ sudo pacman-key --add public.key
$ sudo pacman-key --lsign-key 2D4C887EB08424F157151C493DD50AA7E055D853
$ if grep -e wslutilities /etc/pacman.conf ; then
$   :
$ else
$   echo "[wslutilities]" | sudo tee -a /etc/pacman.conf
$   echo "Server = https://pkg.wslutiliti.es/arch/" | sudo tee -a /etc/pacman.conf
$ fi
$ paru -Sy && paru -S --noconfirm wslu
```

### win32yank.exeのインストール
[win32yank](https://github.com/equalsraf/win32yank)
