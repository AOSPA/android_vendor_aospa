#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_porsche,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/realme/porsche/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := realme
PRODUCT_DEVICE := porsche
PRODUCT_MANUFACTURER := realme
PRODUCT_MODEL := realme GT 2
PRODUCT_NAME := aospa_porsche

PRODUCT_GMS_CLIENTID_BASE := android-oppo

# Override device name for Play Store.
PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceName=RE58B2L1 \
    DeviceProduct=RE58B2L1 \
    SystemDevice=RE58B2L1 \
    SystemName=RE58B2L1

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1080

endif
