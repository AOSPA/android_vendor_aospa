#
# Copyright (C) 2018-2021 ArrowOS
# Copyright (C) 2021 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_vayu,$(TARGET_PRODUCT))

# Inherit common products
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configurations
$(call inherit-product, device/xiaomi/vayu/device.mk)

# Inherit common AOSPA configuration
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_NAME := aospa_vayu
PRODUCT_DEVICE := vayu
PRODUCT_BRAND := POCO
PRODUCT_MODEL := Poco X3 Pro
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="vayu_global-user 11 RKQ1.200826.002 V12.5.4.0.RJUMIXM release-keys"

BUILD_FINGERPRINT := POCO/vayu_global/vayu:11/RKQ1.200826.002/V12.5.4.0.RJUMIXM:user/release-keys

endif
