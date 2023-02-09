#
# Copyright (C) 2023 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_flame,$(TARGET_PRODUCT))

# Inherit some common AOSPA stuff.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Inherit device configuration
$(call inherit-product, device/google/coral/aosp_flame.mk)

include device/google/coral/device-aospa.mk

# Resolution for bootanimation
TARGET_BOOT_ANIMATION_RES := 1080

# Device identifier. This must come after all inclusions
PRODUCT_BRAND := google
PRODUCT_DEVICE := flame
PRODUCT_MANUFACTURER := Google
PRODUCT_NAME := aospa_flame
PRODUCT_MODEL := Pixel 4

PRODUCT_GMS_CLIENTID_BASE := android-google

$(call inherit-product, vendor/google/flame/flame-vendor.mk)

endif
