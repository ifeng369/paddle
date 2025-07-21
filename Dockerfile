FROM ubuntu:24.04

RUN apt-get update && apt-get  install -y \
    python3 \
    python3-pip \
    wget \
    git \
    patchelf \
    && rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    pip config set global.break-system-packages true && \
    pip config set global.extra-index-url https://mirrors.bfsu.edu.cn/pypi/web/simple && \
    pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple && \
    pip config set install.trusted-host mirrors.bfsu.edu.cn/pypi/web/simple


RUN pip install wheel ninja

RUN wget --no-verbose https://cmake.org/files/v3.18/cmake-3.18.0-Linux-x86_64.tar.gz && \
    tar -zxf cmake-3.18.0-Linux-x86_64.tar.gz --strip-components=1 -C /usr/local/ && \
    rm cmake-3.18.0-Linux-x86_64.tar.gz && \
    cmake --version

RUN wget --no-verbose https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-ubuntu2404.pin && \
mv cuda-ubuntu2404.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
wget --no-verbose https://developer.download.nvidia.com/compute/cuda/12.9.1/local_installers/cuda-repo-ubuntu2404-12-9-local_12.9.1-575.57.08-1_amd64.deb && \
dpkg -i cuda-repo-ubuntu2404-12-9-local_12.9.1-575.57.08-1_amd64.deb && \
cp /var/cuda-repo-ubuntu2404-12-9-local/cuda-*-keyring.gpg /usr/share/keyrings/ && \
apt-get update && apt-get -y install cuda-toolkit-12-9 &&  rm cuda-repo-ubuntu2404-12-9-local_12.9.1-575.57.08-1_amd64.deb && \
wget --no-verbose https://developer.download.nvidia.cn/compute/cudnn/redist/cudnn/linux-x86_64/cudnn-linux-x86_64-9.9.0.52_cuda12-archive.tar.xz  && \
tar xJf cudnn-linux-x86_64-9.9.0.52_cuda12-archive.tar.xz && \
rm  cudnn-linux-x86_64-9.9.0.52_cuda12-archive.tar.xz && \
cd cudnn-linux-x86_64-9.9.0.52_cuda12-archive && \
cp include/* /usr/local/cuda-12.9/include/ && \
cp lib/* /usr/local/cuda-12.9/lib64/ 