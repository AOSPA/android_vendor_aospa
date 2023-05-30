# Copyright (C) 2023 Paranoid Android
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

ifeq (aospa_pdx214,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/sony/pdx214/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

PRODUCT_BRAND := Sony
PRODUCT_DEVICE := pdx214
PRODUCT_MANUFACTURER := Sony
PRODUCT_MODEL := Xperia 5 III
PRODUCT_NAME := aospa_pdx214

PRODUCT_GMS_CLIENTID_BASE := android-sonymobile

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1080

endif
