#!/bin/bash
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
