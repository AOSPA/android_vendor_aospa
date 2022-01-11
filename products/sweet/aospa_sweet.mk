#
# Copyright (C) 2021 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from violet device
$(call inherit-product, device/xiaomi/sweet/device.mk)

# Inherit some common AOSPA stuff.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := aospa_sweet
PRODUCT_DEVICE := sweet
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi Note 10 Pro
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080
