#!/bin/bash
sudo apt update && sudo apt-get install -y openssl ccache bc bash git-core gnupg build-essential zip curl make automake autogen autoconf autotools-dev libtool shtool python  m4 gcc libtool zlib1g-dev flex gcc-aarch64-linux-gnu libssl-dev
git clone https://github.com/gifyic/kernel_cherry_sdm439.git --depth=1
wget https://morning-grape-butterkase.glitch.me/杂七杂八/Candy_clang-20201120.tar.zst
sudo apt-get install -y zstd
mkdir cbl && tar -I zstd -xvf Candy_clang-20201120.tar.zst -C cbl
