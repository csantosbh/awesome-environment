## Put this file into ~/.oh-my-zsh/custom

# Git aliases
alias gs='git status'
alias gl='git log'
alias gd='git diff'
alias gp='git pull'
alias gap='git add -p'
alias gcp='git checkout -p'
alias g='git'

# Improve ls
alias ls='ls -a --color=auto'
alias ag='ag -i'

# Usage: `fnd <name-portion>` will look for files that contain <name-portion> (case insesitive)
function fnd() {
    find -iname "*$1*"
}
