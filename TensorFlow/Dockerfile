FROM tensorflow/tensorflow:latest-gpu-py3
ENV workdir /workspace

WORKDIR ${workdir}

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y tmux python3-tk && \
    pip3 install --upgrade pip && \
    pip3 install matplotlib
