# catppuccin options...
set -g @catppuccin_flavor 'kanagawa' # latte, frappe, macchiato or mocha
set -g @catppuccin_window_default_fill "none"
set -g @catppuccin_window_current_fill "all"
set -g @catppuccin_window_current_text "#W
#{?window_activity_flag, 󱅫 ,}
#{?window_bell_flag, 󰂞 ,}
#{?window_silence_flag, 󰂛 ,}
# #{?window_active, 󰖯 ,}
#{?window_marked_flag, 󰃀 ,}
#{?window_zoomed_flag, 󰁌 ,}
"
set -g @catppuccin_window_default_text "#W
# #{?window_last_flag, 󰖰 ,}
#{?window_activity_flag, 󱅫 ,}
#{?window_bell_flag, 󰂞 ,}
#{?window_silence_flag, 󰂛 ,}
#{?window_marked_flag, 󰃀 ,}
#{?window_zoomed_flag, 󰁌 ,}
"
set -g @catppuccin_status_fill "all"
set -g @catppuccin_directory_text "#{pane_current_path}"
set -g @catppuccin_status_right_separator " "
set -g @catppuccin_status_connect_separator "no"

set -g @catppuccin_window_status_style "rounded"

run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux

set -g status-left "#{E:@catppuccin_status_session}"
set -g status-right ""

set -gF status-left-length 100
