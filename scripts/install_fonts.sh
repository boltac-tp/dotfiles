sudo mkdir -p /usr/local/share/fonts/TTF
HACK_GEN_NERD_VER=$(git ls-remote https://github.com/yuru7/HackGen | grep refs/tags | grep -oE "v[0-9]\.[0-9][0-9]?\.[0-9][0-9]?" | sort --version-sort | tail -n 1)
PLEMOL_NERD_VER=$(git ls-remote https://github.com/yuru7/Plemoljp | grep refs/tags | grep -oE "v[0-9]\.[0-9][0-9]?\.[0-9][0-9]?" | sort --version-sort | tail -n 1)
wget -q https://github.com/yuru7/HackGen/releases/download/"${HACK_GEN_NERD_VER}"/HackGen_NF_"${HACK_GEN_NERD_VER}".zip
unzip HackGen_NF_"${HACK_GEN_NERD_VER}".zip
sudo cp HackGen_NF_"${HACK_GEN_NERD_VER}"/HackGen* /usr/local/share/fonts
rm -rf HackGen*
wget -q https://github.com/yuru7/PlemolJP/releases/download/"${PLEMOL_NERD_VER}"/PlemolJP_"${PLEMOL_NERD_VER}".zip
unzip PlemolJP_"${PLEMOL_NERD_VER}".zip
sudo cp PlemolJP_"${PLEMOL_NERD_VER}"/PlemolJPConsole/PlemolJPConsole* /usr/local/share/fonts
rm -rf PlemolJP*
