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

ifeq (aospa_lynx,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/google/lynx/aosp_lynx.mk)

include device/google/lynx/device-aospa.mk

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Resolution for bootanimation
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_BRAND := google
PRODUCT_DEVICE := lynx
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Pixel 7a
PRODUCT_NAME := aospa_lynx

PRODUCT_GMS_CLIENTID_BASE := android-google

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_DEVICE=Pixel7 \
    PRIVATE_BUILD_DESC="lynx-user 13 TQ2B.230505.005.A1 9808202 release-keys"

BUILD_FINGERPRINT := google/lynx/lynx:13/TQ3A.230605.012/10204971:user/release-keys

endif
