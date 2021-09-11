#!/bin/bash
echo "更新源，以及安装所需环境" && sudo apt update && sudo apt-get install -y openssl ccache bc bash git-core gnupg build-essential zip curl make automake autogen autoconf autotools-dev libtool shtool python  m4 gcc libtool zlib1g-dev flex gcc-aarch64-linux-gnu libssl-dev
if [ -d $GITHUB_WORKSPACE/kernel_cherry_sdm439 ];then
   echo "内核源码已存在，跳过下载"
else 
   echo "内核源码未下载，开始下载" && git clone https://github.com/gifyic/kernel_cherry_sdm439.git --depth=1
fi
if [ -d $GITHUB_WORKSPACE/Candy_clang-20201120.tar.zst ];then
   echo "ClangBuiltLinux Clang 已下载，跳过下载"
else
   echo "ClangBuiltLinux Clang 未下载，开始下载" && wget https://morning-grape-butterkase.glitch.me/OnedriveXbot/Candy_clang-20201120.tar.zst
fi
echo "安装zstd支持" && sudo apt-get install -y zstd
echo "开始解压ClangBuiltLinux Clang" && mkdir cbl && tar -I zstd -xvf Candy_clang-20201120.tar.zst -C cbl
echo "进入内核源码根目录"
cd $GITHUB_WORKSPACE/kernel_cherry_sdm439
args="-j$(nproc --all) \
	O=out \
	ARCH=arm64 \
	CLANG_TRIPLE=aarch64-linux-gnu- \
	CROSS_COMPILE=$GITHUB_WORKSPACE/cbl/bin/aarch64-linux-gnu- \
	CC=$GITHUB_WORKSPACE/cbl/bin/clang \
	CROSS_COMPILE_ARM32=$GITHUB_WORKSPACE/cbl/bin/arm-linux-gnueabi- "
	make ${args} cherry-sdm439_defconfig
	make ${args}
curl -sL https://git.io/cowtransfer | sh
cd $GITHUB_WORKSPACE/kernel_cherry_sdm439/out/arch/arm64/boot
zip -q -r kernel.zip *
./cowtransfer-uploader $GITHUB_WORKSPACE/kernel_cherry_sdm439/out/arch/arm64/boot/kernel.zip
