# Copyright (C) 2021 Paranoid Android
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
ifeq (aospa_lavender,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/xiaomi/lavender/device.mk)

# Inherit some common AOSPA stuff.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Build Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE="lavender" \
    PRODUCT_NAME="lavender" \
    PRIVATE_BUILD_DESC="lavender-user 9 PKQ1.180904.001 V10.3.9.0.PFGMIXM release-keys"

# Device identifier
PRODUCT_NAME := aospa_lavender
PRODUCT_DEVICE := lavender
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi Note 7
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

TARGET_BOOT_ANIMATION_RES := 1080

endif
