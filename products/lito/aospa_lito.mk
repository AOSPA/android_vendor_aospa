#
# Copyright (C) 2023 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_lito,$(TARGET_PRODUCT))
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the device configuration.
$(call inherit-product, device/qcom/lito/lito.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_MANUFACTURER := QUALCOMM
PRODUCT_BRAND := qti
PRODUCT_NAME := aospa_lito
PRODUCT_DEVICE := lito
PRODUCT_MODEL := lito for arm64

PRODUCT_GMS_CLIENTID_BASE := android-qualcomm
PRODUCT_SYSTEM_NAME := lito
PRODUCT_SYSTEM_DEVICE := lito

# Override device name for Play Store.
PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=$(PRODUCT_SYSTEM_DEVICE) \
    TARGET_PRODUCT=$(PRODUCT_SYSTEM_NAME)

endif
