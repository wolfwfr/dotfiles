# colour styling
# set-option -g terminal-overrides ',xterm-256color:RGB'
set -g default-terminal "xterm-kitty"
set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m' # fixes colours in neovim & displays italics font without changing background colours
# set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
# set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colors - needs tmux-3.0
set -g pane-active-border-style 'fg=magenta,bg=default'
set -g pane-border-style 'fg=brightblack,bg=default'

# set status bar to top
set-option -g status-position top

# start windows and panes at 1, not 0
set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# don't rename windows automatically
set-option -g allow-rename off

# enable vi copy-mode in terminal
setw -g mode-keys vi

