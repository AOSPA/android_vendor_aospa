#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

# Check for target product
ifeq (aospa_oneplus7tpro,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/oneplus/oneplus7tpro/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Override AOSP build properties
PRODUCT_NAME := aospa_oneplus7tpro
PRODUCT_DEVICE := oneplus7tpro
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := HD1917
PRODUCT_MANUFACTURER := OnePlus

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1440

PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceName=OnePlus7TPro \
    DeviceProduct=OnePlus7TPro \
    SystemDevice=OnePlus7TPro \
    SystemName=OnePlus7TPro

endif
