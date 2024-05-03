set -x PATH $PATH /usr/local/go/bin ~/go/bin
set -x PATH $PATH /home/wolf/.local/kitty.app/bin
set -x PATH $PATH /home/wolf/.config/tmux/plugins/tmuxifier/bin
set -x TERM xterm-color
set -x GO111MODULE on
set -x AWS_REGION us-east-1
set -x CHROME_BIN /snap/bin/chromium

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
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias bat="batcat"
alias ls="eza --color=always --long --git"
alias lss="eza --color=always --icons=always --long --no-filesize --no-time --no-user --no-permissions"

thefuck --alias | source

eval (tmuxifier init - fish)

export BAT_THEME="kanagawa"
