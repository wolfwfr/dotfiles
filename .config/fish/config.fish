set -x PATH $PATH /usr/local/go/bin ~/go/bin
set -x PATH $PATH /home/wolf/.local/kitty.app/bin
set -x TERM xterm-color
set -x GO111MODULE on
set -x AWS_REGION us-east-1
set -x CHROME_BIN /snap/bin/chromium

alias dup="docker compose up -d"
alias down="docker compose down"
alias dops="docker ps"
alias dil="docker kill"
alias got="go test ./..."
alias awscode="ykman oath accounts code aws"
alias n="nvim ."
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

thefuck --alias | source
