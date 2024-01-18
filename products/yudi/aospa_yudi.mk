#
# Copyright (C) 2024 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_yudi,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit from the device configuration.
$(call inherit-product, device/xiaomi/yudi/device.mk)

# Inherit from the AOSPA configuration.
TARGET_NO_TELEPHONY := true
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := Xiaomi
PRODUCT_DEVICE := yudi
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := 2307BRPDCC
PRODUCT_NAME := aospa_yudi

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_PRODUCT=yudi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Boot Animation
TARGET_BOOT_ANIMATION_RES := 1080

# Tablet Wallpapers
PRODUCT_PACKAGES += \
    AOSPAFrameworksTabletOverlay

endif
