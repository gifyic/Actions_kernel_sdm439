#!/bin/bash
cd $GITHUB_WORKSPACE/kernel_cherry_sdm439/out/arch/arm64/boot
curl -sL https://git.io/file-transfer | sh
zip -q -r kernel.zip *
./transfer gof ./kernel.zip
