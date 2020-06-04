ARG UBUNTU_VERSION=18.04
ARG CUDA=10.1

FROM nvidia/cudagl:${CUDA}-base-ubuntu${UBUNTU_VERSION}
ENV workdir /workspace

WORKDIR ${workdir}

# CUDA is specified again because the FROM directive resets ARGs
# (but its default value is retained if set previously)
ARG CUDA
ARG CUDNN=7.6.4.38-1
ARG CUDNN_MAJOR_VERSION=7
ARG DEBIAN_FRONTEND=noninteractive
ARG LIB_DIR_PREFIX=x86_64
ARG LIBNVINFER=6.0.1-1
ARG LIBNVINFER_MAJOR_VERSION=6

# Needed for string substitution
SHELL ["/bin/bash", "-c"]

# Pick up some TF dependencies
RUN apt update && \
    apt install -y --no-install-recommends \
    build-essential \
    cuda-command-line-tools-${CUDA/./-} \
    # There appears to be a regression in libcublas10=10.2.2.89-1 which
    # prevents cublas from initializing in TF. See
    # https://github.com/tensorflow/tensorflow/issues/9489#issuecomment-562394257
    libcublas10=10.2.1.243-1 \ 
    cuda-nvrtc-${CUDA/./-} \
    cuda-cufft-${CUDA/./-} \
    cuda-curand-${CUDA/./-} \
    cuda-cusolver-${CUDA/./-} \
    cuda-cusparse-${CUDA/./-} \
    curl \
    libcudnn7=${CUDNN}+cuda${CUDA} \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libzmq3-dev \
    pkg-config \
    software-properties-common \
    unzip

# Install TensorRT
RUN apt-get update && \
    apt-get install -y --no-install-recommends libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda${CUDA} \
    libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda${CUDA} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*;

# For CUDA profiling, TensorFlow requires CUPTI.
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Link the libcuda stub to the location where tensorflow is searching for it and reconfigure
# dynamic linker run-time bindings
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 \
    && echo "/usr/local/cuda/lib64/stubs" > /etc/ld.so.conf.d/z-cuda-stubs.conf \
    && ldconfig

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

RUN python3 -m pip --no-cache-dir install --upgrade \
    pip \
    setuptools

# Some TF tools expect a "python" binary
RUN ln -s $(which python3) /usr/local/bin/python

# Options:
#   tensorflow
#   tensorflow-gpu
#   tf-nightly
#   tf-nightly-gpu
# Set --build-arg TF_PACKAGE_VERSION=1.11.0rc0 to install a specific version.
# Installs the latest version by default.
ARG TF_PACKAGE=tensorflow
ARG TF_PACKAGE_VERSION=
RUN python3 -m pip install --no-cache-dir ${TF_PACKAGE}${TF_PACKAGE_VERSION:+==${TF_PACKAGE_VERSION}}

# Install useful packages for this environment
RUN apt install -y --no-install-recommends \
    language-pack-en \
    tmux \
    python3-tk \
    libvtk6-dev \
    libx11-dev \
    mesa-common-dev \
    libegl1-mesa-dev \
    libgtk-3-dev

RUN python3 -m pip --no-cache-dir install \
    matplotlib \
    wxpython \
    mayavi \
    pandas \
    seaborn

COPY bashrc /etc/bash.bashrc
RUN chmod a+rwx /etc/bash.bashrc

