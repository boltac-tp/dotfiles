#!/bin/bash

# install wezterm
flatpak install flathub org.wezfurlong.wezterm
mkdir -p ~/.config/wezterm/wezterm
ln -s ~/dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
