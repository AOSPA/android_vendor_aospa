#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_pdx215,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/sony/pdx215/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := Sony
PRODUCT_DEVICE := pdx215
PRODUCT_MANUFACTURER := Sony
PRODUCT_MODEL := Xperia 1 III
PRODUCT_NAME := aospa_pdx215

PRODUCT_GMS_CLIENTID_BASE := android-sonymobile

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 2160

endif
