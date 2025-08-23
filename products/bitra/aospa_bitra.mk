#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_bitra,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/realme/bitra/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := realme
PRODUCT_DEVICE := bitra
PRODUCT_MANUFACTURER := realme
PRODUCT_MODEL := RMX3370
PRODUCT_NAME := aospa_bitra

PRODUCT_GMS_CLIENTID_BASE := android-oppo

PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceName=RE879AL1 \
    DeviceProduct=RMX3370 \
    SystemDevice=RE879AL1 \
    SystemName=RMX3370

endif
