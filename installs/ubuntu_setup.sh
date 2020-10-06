#!/usr/bin/env bash

sudo apt update
sudo apt install -y \
    build-essential \
    tmux \
    zsh \
    silversearcher-ag \
    htop \
    command-not-found \
    octave \
    vim \
    curl \
    mlocate \
    xclip \
    libeigen3-dev \
    libglm-dev \
    liboctave-dev

# Install and configure oh-my-zsh
export RUNZSH=no
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install anaconda
ANACONDA_SH=Anaconda3-2020.07-Linux-x86_64.sh
if [ ! -f ${ANACONDA_SH} ]; then
	wget https://repo.anaconda.com/archive/${ANACONDA_SH}
fi
bash ./${ANACONDA_SH}
rm ${ANACONDA_SH}
if [ -d ~/anaconda3/ ]; then
	~/anaconda3/bin/conda init zsh
fi

# Copy configuration files to proper folders
cp ../shell/.ideavimrc ../shell/.vimrc ~/
cp ../shell/zsh_extensions.zsh ~/.oh-my-zsh/custom

# Install pathogen (vim package manager)
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
          curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install vim plugins
if [ ! -d ~/.vim/bundle/vim-easymotion ]; then
    git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion
fi

# Configure git
git config --global core.editor "vim"
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff

