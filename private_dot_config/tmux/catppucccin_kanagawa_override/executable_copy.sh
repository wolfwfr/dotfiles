#! /bin/bash

wget https://github.com/catppuccin/tmux/archive/refs/tags/v1.0.3.zip -O /tmp/catppuccin.zip
unzip /tmp/catppuccin.zip -d /tmp/
mkdir -p ~/.config/tmux/plugins/catppuccin/tmux
cp -r /tmp/tmux-1.0.3/* ~/.config/tmux/plugins/catppuccin/tmux/
cp ./catppuccin_kanagawa_tmux.conf ../plugins/catppuccin/tmux/themes/catppuccin_kanagawa_tmux.conf
