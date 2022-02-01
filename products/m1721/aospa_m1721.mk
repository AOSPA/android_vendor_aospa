#
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
#

# Check for target product
ifeq (aospa_m1721,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from m1721 device
$(call inherit-product, device/meizu/m1721/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := m1721
PRODUCT_NAME := aospa_m1721
PRODUCT_BRAND := Meizu
PRODUCT_MODEL := M6 Note
PRODUCT_MANUFACTURER := Meizu
BOARD_VENDOR := Meizu

PRODUCT_GMS_CLIENTID_BASE := android-meizu

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := "Meizu/meizu_M6Note/M6Note:7.1.2/N2G47H/m1721.Flyme_6.0.1528193190:user/release-keys"

# Boot animation resolution.
TARGET_BOOT_ANIMATION_RES := 1080

endif
