#!/bin/bash
echo "更新源，以及安装所需环境" && sudo apt update && sudo apt-get install -y openssl ccache bc bash git-core gnupg build-essential zip curl make automake autogen autoconf autotools-dev libtool shtool python  m4 gcc libtool zlib1g-dev flex gcc-aarch64-linux-gnu libssl-dev
git clone --recurse-submodules https://github.com/gifyic/paper-xm-msm8998-kernel.git --depth=1
wget https://service-85nm4dou-1306003300.hk.apigw.tencentcs.com/release/start-test-1632887300/Candy_clang-20201120.tar.zst
echo "安装zstd支持" && sudo apt-get install -y zstd
echo "开始解压ClangBuiltLinux Clang" && mkdir cbl && tar -I zstd -xvf Candy_clang-20201120.tar.zst -C cbl
echo "进入内核源码根目录"
cd $GITHUB_WORKSPACE/paper-xm-msm8998-kernel
args="-j$(nproc --all) \
	O=out \
	ARCH=arm64 \
	CLANG_TRIPLE=aarch64-linux-gnu- \
	CROSS_COMPILE=$GITHUB_WORKSPACE/cbl/bin/aarch64-linux-gnu- \
	CC=$GITHUB_WORKSPACE/cbl/bin/clang \
	CROSS_COMPILE_ARM32=$GITHUB_WORKSPACE/cbl/bin/arm-linux-gnueabi- "
	make ${args} sagit_defconfig
	make ${args}
