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

ifeq (aospa_lime,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/xiaomi/lime/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := Redmi
PRODUCT_DEVICE := lime
PRODUCT_MANUFACTURER := Redmi
PRODUCT_MODEL := Redmi 9T
PRODUCT_NAME := aospa_lime

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Override device name for Play Store.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_DEVICE=lime

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1080

endif
