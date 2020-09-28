#!/usr/bin/env bash

sudo apt update
sudo apt install -y \
    build-essential \
    zsh \
    silversearcher-ag \
    htop \
    command-not-found \
    octave \
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
