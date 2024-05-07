# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-s
bind-key C-s send-prefix

# split panes using | and -
bind / split-window -h -c "#{pane_current_path}"     # split panes horizontally in current directory
bind - split-window -v -c "#{pane_current_path}"     # split panes vertically in current directory
bind z resize-pane -Z       # zoom selected pane using z

bind : command-prompt
bind x swap-pane -D
unbind '"'
unbind %

bind -n M-H previous-window # frees up prefix-n
bind -n M-L next-window # frees ups prefix-n

bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

# reload config file
bind r source-file ~/.config/tmux/tmux.conf \; display " Reloaded!"

