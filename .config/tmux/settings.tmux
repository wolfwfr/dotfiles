# colour styling
set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m' # fixes colours in neovim & displays italics font without changing background colours
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

