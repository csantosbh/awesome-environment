#!/usr/bin/env bash

sudo apt update
sudo apt install -y \
    build-essential \
    tmux \
    zsh \
    gifsicle \
    silversearcher-ag \
    htop \
    command-not-found \
    octave \
    vim \
    curl \
    mlocate \
    xclip \
    libeigen3-dev \
    graphviz \
    libglm-dev \
    liboctave-dev

# Install and configure oh-my-zsh
export RUNZSH=no
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install conda
if [ ! -d ~/miniconda3/ ]; then
    CONDA_SH=Miniconda3-latest-Linux-x86_64.sh
    if [ ! -f ${CONDA_SH} ]; then
        wget https://repo.anaconda.com/miniconda/${CONDA_SH}
    fi
    bash ./${CONDA_SH}
    rm ${CONDA_SH}
    if [ -d ~/miniconda3/ ]; then
        ~/miniconda3/bin/conda init zsh
    fi
else
    echo "Conda already installed; skipping installation..."
fi

# Copy configuration files to proper folders
cp ../shell/.ideavimrc ../shell/.vimrc ../shell/.tmux.conf ~/
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

# Python libs
pip install pydot

# Done!
echo "Done! Enjoy your new environment."
