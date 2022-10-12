#
# Copyright (C) 2022 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# Check for target product
ifeq (aospa_hotdogb,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/oneplus/hotdogb/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Override AOSP build properties
PRODUCT_NAME := aospa_hotdogb
PRODUCT_DEVICE := hotdogb
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_MODEL := HD1901
PRODUCT_BRAND := OnePlus

PRODUCT_SYSTEM_NAME := OnePlus7T
PRODUCT_SYSTEM_DEVICE := OnePlus7T

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=$(PRODUCT_SYSTEM_DEVICE) \
    TARGET_PRODUCT=$(PRODUCT_SYSTEM_NAME)

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1080

endif
