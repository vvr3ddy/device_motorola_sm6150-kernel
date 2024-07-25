#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_KERNEL_PATH := device/motorola/sm6150-kernel

DEVICE_KERNEL_PATH := $(COMMON_KERNEL_PATH)/$(TARGET_DEVICE)

# Flag required to use prebuilt kernel (LineageOS)
TARGET_FORCE_PREBUILT_KERNEL := true

BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_KERNEL_PATH)/dtbo.img
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_KERNEL_PATH)/dtb
TARGET_PREBUILT_KERNEL := $(DEVICE_KERNEL_PATH)/kernel

# Copy out modules
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_KERNEL_PATH)/modules/vendor/,$(TARGET_COPY_OUT_VENDOR)/lib/modules)

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_KERNEL_PATH)/modules/vendor_ramdisk/,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules)

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_KERNEL_PATH)/firmware/,$(TARGET_COPY_OUT_VENDOR)/firmware)
