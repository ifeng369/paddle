#!/bin/bash
set -e
echo "编译"
cd /
git config --global http.https://github.com.proxy socks5://192.168.16.17:10808

# git clone -b release/3.1 --depth 1 https://github.com/PaddlePaddle/Paddle.git
# pip install -r /Paddle/python/requirements.txt
# mkdir -p /build/paddle/phi/ops/yaml/inconsistent
# mkdir -p /build/paddle/phi/ops/yaml/legacy
cd /build
cmake /Paddle -GNinja -DWITH_GPU=ON -DWITH_NCCL=OFF -DCMAKE_CUDA_COMPILER=/usr/local/cuda-12.9/bin/nvcc -DCUDNN_ROOT=/usr/local/cuda-12.9 -DCUDA_ARCH_NAME=Manual -DCUDA_ARCH_BIN=120 -DWITH_UNITY_BUILD=ON
ninja all


echo "编译完成"