# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'sainnhe/tmux-fzf'

# tmux-kanagawa
set -g @plugin 'Nybkox/tmux-kanagawa'
set -g @kanagawa-plugins "cpu-usage ram-usage"
set -g @kanagawa-show-powerline true
set -g @kanagawa-show-left-sep  
set -g @kanagawa-show-right-sep 

# tmux-resurrect
set -g @plugin 'tmux-plugins/tmux-resurrect'
resurrect_dir="$HOME/.tmux/resurrect"
set -g @resurrect-processes 'true'
set -g @resurrect-dir $resurrect_dir
set -g @resurrect-strategy-nvim 'session'
# tmux-resurrect stores a link to the process bin as absolute path in my config, but restore doesn't support absolute path. So pre-restore, the path-prefix is removed, such that only the 'nvim' command remains
# requires sponge
set -g @resurrect-hook-pre-restore-all 'target=$(readlink -f $resurrect_dir/last); sed "s|/squashfs-root/usr/bin/||g" $target | sponge $target'
set -g @resurrect-processes 'neofetch neo btop wtfutil'
set -g @resurrect-capture-pane-contents 'on'

# tmux-continuum
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @continuum-restore 'on'


