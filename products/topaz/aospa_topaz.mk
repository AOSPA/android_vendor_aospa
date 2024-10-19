#
# Copyright (C) 2024 Paranoid Android
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
#

# Check for target product
ifeq (aospa_topaz,$(TARGET_PRODUCT))

# Inherit from framework configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from topaz device configuration
$(call inherit-product, device/xiaomi/topaz/device.mk)

# Inherit from common AOSPA configuration
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Device identifier
PRODUCT_NAME := aospa_topaz
PRODUCT_DEVICE := topaz
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi Note 12 NFC
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080

endif
