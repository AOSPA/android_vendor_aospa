#
# Copyright (C) 2023 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_liuqin,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit from the device configuration.
$(call inherit-product, device/xiaomi/liuqin/device.mk)

# Inherit from the AOSPA configuration.
TARGET_NO_TELEPHONY := true
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := Xiaomi
PRODUCT_DEVICE := liuqin
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := 23046RP50C
PRODUCT_NAME := aospa_liuqin

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_PRODUCT=liuqin

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Boot Animation
TARGET_BOOT_ANIMATION_RES := 1080

# Tablet Wallpapers
PRODUCT_PACKAGES += \
    AOSPAFrameworksTabletOverlay

endif
