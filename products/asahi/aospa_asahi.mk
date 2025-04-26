#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_asahi,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/sony/asahi/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := Sony
PRODUCT_DEVICE := asahi
PRODUCT_MANUFACTURER := Sony
PRODUCT_MODEL := Xperia 1 VI
PRODUCT_NAME := aospa_asahi

PRODUCT_GMS_CLIENTID_BASE := android-sonymobile

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 2160

endif
