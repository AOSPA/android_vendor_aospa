#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_oneplus9,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/oneplus/oneplus9/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := OnePlus
PRODUCT_DEVICE := oneplus9
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_MODEL := LE2115
PRODUCT_NAME := aospa_oneplus9

PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceName=OnePlus9 \
    DeviceProduct=OnePlus9 \
    SystemDevice=OnePlus9 \
    SystemName=OnePlus9

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1080

endif
