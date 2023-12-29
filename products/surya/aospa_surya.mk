# Copyright (C) 2023 Paranoid Android
# SPDX-License-Identifier: Apache-2.0

# Check for target product
ifeq (aospa_surya, $(TARGET_PRODUCT))

# Inherit from framework first
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from surya device configuration
$(call inherit-product, device/xiaomi/surya/device.mk)

# Inherit from common AOSPA configuration
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Device identifier
PRODUCT_NAME := aospa_surya
PRODUCT_DEVICE := surya
PRODUCT_BRAND := POCO
PRODUCT_MODEL := POCO X3 NFC
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_PRODUCT=surya_global

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080

endif
