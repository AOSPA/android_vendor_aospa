#
# Copyright (C) 2023-2024 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_x40,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the device configuration.
$(call inherit-product, device/motorola/x40/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := motorola
PRODUCT_DEVICE := x40
PRODUCT_MANUFACTURER := motorola
PRODUCT_MODEL := motorola edge 40 pro
PRODUCT_NAME := aospa_x40

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_PRODUCT=rtwo_g

PRODUCT_GMS_CLIENTID_BASE := android-motorola

# Boot Animation
TARGET_BOOT_ANIMATION_RES := 1080

endif
