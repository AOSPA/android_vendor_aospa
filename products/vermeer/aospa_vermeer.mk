#
# Copyright (C) 2024 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_vermeer,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the device configuration.
$(call inherit-product, device/xiaomi/vermeer/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := POCO
PRODUCT_DEVICE := vermeer
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := vermeer
PRODUCT_NAME := aospa_vermeer

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_PRODUCT=vermeer

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Boot Animation
TARGET_BOOT_ANIMATION_RES := 1440

endif
