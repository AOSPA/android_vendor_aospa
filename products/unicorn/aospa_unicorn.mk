#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_unicorn,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/xiaomi/unicorn/unicorn.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Device identifier
PRODUCT_BRAND := xiaomi
PRODUCT_DEVICE := unicorn
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_MODEL := 2206122SC
PRODUCT_NAME := unicorn

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceProduct=unicorn \
    SystemName=unicorn

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1440

endif
