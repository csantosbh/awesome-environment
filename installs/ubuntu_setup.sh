#!/usr/bin/env bash

sudo apt update
sudo apt install -y \
    build-essential \
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

# Install anaconda
cd /tmp/
ANACONDA_SH=Anaconda3-2020.07-Linux-x86_64.sh
wget https://repo.anaconda.com/archive/${ANACONDA_SH}
bash ./${ANACONDA_SH}

# Install and configure oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy configuration files to proper folders
cp ../shell/.ideavimrc ../shell/.vimrc ~/
cp ../shell/zsh_extensions.zsh ~/.oh-my-zsh/custom

# Install pathogen (vim package manager)
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
          curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install vim plugins
git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion