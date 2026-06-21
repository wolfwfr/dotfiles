# Catppuccin kanagawa override

Adds a new theme file to the catppuccin themes folder.

## What happens

This script will download the v1.0.3 catppuccin theme for tmux, unzip, and copy
the contents to the tmux/plugins directory. Then it adds a custom theme file for
my own kanagawa theme.

## How to apply

1. navigate to this directory.
2. ensure you have rights to execute `copy.sh` and run `./copy.sh`
3. Set the catppuccin theme to 'kanagawa', like so:
   `set -g @catppuccin_flavor 'kanagawa'`
