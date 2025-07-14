set -x PATH $PATH /usr/local/go/bin ~/go/bin
set -x PATH $PATH /home/wolf/.local/kitty.app/bin
#set -x PATH $PATH /home/wolf/.config/tmux/plugins/tmuxifier/bin
set -x TERM xterm-256color
set -x GO111MODULE on
set -x AWS_REGION us-east-1
set -x CHROME_BIN /snap/bin/chromium
# set -x JIRA_AUTH_TYPE bearer

set -g fish_greeting

alias dup="docker compose up -d"
alias down="docker compose down"
alias dops="docker ps"
alias dil="docker kill"
alias dip="docker image prune -a --filter " # followed by format: "until=2024-01-01T00:00:00"
alias dsp="docker system prune"
alias got="go test ./..."
alias gt="git tag -l | sort -V | tail"
alias awscode="ykman oath accounts code aws"
alias n="nvim ."
alias ns="nvim" # ns=nvim session (auto-session will create or load a session)
alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias lazydot="lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias ls="eza --color=always --long --git"
alias lss="eza --color=always --icons=always --long --no-filesize --no-time --no-user --no-permissions"
alias cnvim="rm /home/wolf/.local/state/nvim/shada/*"
alias rsred="redshift -O 4500"
alias rsreset="redshift -x"
alias avl="aws-vault list"
alias ave="aws-vault exec admin"
alias aves="aws-vault exec --server admin"
alias avel="aws-vault exec admin --duration=8h"
alias sourcefish="source ~/.config/fish/config.fish"
alias jira='JIRA_API_TOKEN=$(pass show jira/api_token) /usr/bin/jira'
alias yrc='ykman oath accounts code --single redis | wl-copy -n' # using wayland's clipboard
alias yac='ykman oath accounts code --single aws | wl-copy -n' # using wayland's clipboard
alias cl='clockify-cli'

# credit: https://unix.stackexchange.com/questions/6910/there-must-be-a-better-way-to-replace-single-newlines-only
# if line starts (^) with end of line ($); print newline; if any character (.) print
# the whole line ($0) and append with space.
alias trimendnl='awk \' /^$/ { print "\n"; } /./ { printf("%s ", $0); } \''

# redshifting for wayland
alias wlreset="pidof \"wlsunset\" | xargs kill"
function wlred
    wlsunset -T 4500 &
end

function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

thefuck --alias | source

#eval (tmuxifier init - fish)

export BAT_THEME="kanagawa"

zoxide init fish | source
direnv hook fish | source
