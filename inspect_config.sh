#!/bin/bash

# Download the appropriate toolchain here:
# clang-r383902c 				https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/refs/tags/platform-tools-31.0.0					Click clang-r383902c -> Click [tgz]
# aarch64-linux-android-4.9			https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/+/refs/tags/platform-tools-31.0.0 		Click [tgz]

defconfig_folder=arch/arm64/configs
kernel_root=/home/srv/new_tree
clang_path=/home/srv/google_clang/clang-r383902c
arm64_gcc_path=/home/srv/google_clang/aarch64-linux-android-4.9
kernel_output_path=out/arch/arm64/boot

mkdir -p out
export ARCH=arm64
export SUBARCH=arm64
export CLANG_PATH=$clang_path/bin
export PATH=${CLANG_PATH}:${PATH}
export DTC_EXT=$kernel_root/dtc-aosp
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=$arm64_gcc_path/bin/aarch64-linux-android-

# Device specific
export ASUS_BUILD_PROJECT=ZS670KS
make CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out -j$(nproc) "vendor/ZS670KS-perf_defconfig"

make CC=clang AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out -j$(nproc) menuconfig
