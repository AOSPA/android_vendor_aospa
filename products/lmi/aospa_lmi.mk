#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

# Check for target product
ifeq (aospa_lmi,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration
$(call inherit-product, device/xiaomi/lmi/device.mk)

# Inherit common AOSPA configuration
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1080

# Override AOSP properties
PRODUCT_NAME := aospa_lmi
PRODUCT_DEVICE := lmi
PRODUCT_BRAND := POCO
PRODUCT_MODEL := POCO F2 Pro
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

endif
