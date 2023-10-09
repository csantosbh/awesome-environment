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
alias ag='ag -i --pager less'

# Usage: `fnd <name-portion>` will look for files that contain <name-portion> (case insesitive)
function fnd() {
    find -iname "*$1*"
}

function vid2gif() {
    if [ ! -e "$1" ]; then
        echo "How to run: $0 <video_name.mp4>.\nWill produce a gif <video_name.gif>."
        return
    fi
    fname=$1
    outname=${fname%.*}.gif
    palette_name=___palette___.png
    ffmpeg -i $fname -vf fps=15,scale=320:-1:flags=lanczos,palettegen $palette_name
    ffmpeg -i "$fname" -i $palette_name -filter_complex "fps=24,scale=720:-1:flags=lanczos[x];[x][1:v]paletteuse" $outname
    rm $palette_name
    gifsicle -O3 --lossy=80 --colors=192 $outname -o $outname
}
