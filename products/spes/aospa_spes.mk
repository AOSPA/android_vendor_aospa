#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

# Check for target product
ifeq (aospa_spes,$(TARGET_PRODUCT))

# Inherit from framework configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from spes device configuration
$(call inherit-product, device/xiaomi/spes/device.mk)

# Inherit from common AOSPA configuration
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Device identifier
PRODUCT_NAME := aospa_spes
PRODUCT_DEVICE := spes
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi Note 11
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080

endif
