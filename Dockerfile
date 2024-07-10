FROM quay.io/jupyter/base-notebook:ubuntu-22.04

COPY pip.conf /etc/pip.conf

USER root
# 更新 apt 源列表
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget curl libgomp1 libegl1 libgl1 build-essential cmake ninja-build vim nano unzip unrar && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*

ENV MAMBA_ROOT_PREFIX=/opt/conda \
    MAMBA_CHANNELS="https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/" \
    MAMBA_SHOW_CHANNEL_URLS=1

USER jovyan
RUN pip install --no-cache --no-cache-dir -U scipy opencv-contrib-python-headless opencv-python-headless black autopep8 matplotlib seaborn numpy open3d toml


EXPOSE 8888
