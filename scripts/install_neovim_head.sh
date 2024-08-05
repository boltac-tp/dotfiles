wget -q https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz -C ~/.local/share/
rm nvim-linux64.tar.gz

if ! [ -e ~/.local/bin/nvim ]; then
	ln -s ~/.local/share/nvim-linux64/bin/nvim ~/.local/bin/nvim
fi

nvim --version
