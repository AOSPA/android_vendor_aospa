# Copyright (C) 2022 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Check for target product
ifeq (aospa_oneplus7,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/oneplus/oneplus7/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Override AOSP build properties
PRODUCT_NAME := aospa_oneplus7
PRODUCT_DEVICE := oneplus7
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := GM1905
PRODUCT_MANUFACTURER := OnePlus

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_SYSTEM_NAME := oneplus7
PRODUCT_SYSTEM_DEVICE := oneplus7

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=OnePlus7 \
    TARGET_PRODUCT=OnePlus7

# Stock fingerprint for ARCore
PRODUCT_SYSTEM_PROPERTIES += \
    ro.stock.build.fingerprint=OnePlus/OnePlus7/OnePlus7:11/RKQ1.201022.002/2205261816:user/release-keys

endif
