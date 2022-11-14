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

ifeq (aospa_panther,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the custom device configuration.
$(call inherit-product, device/google/pantah/aosp_panther.mk)

include device/google/pantah/device-aospa.mk

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Resolution for bootanimation
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_BRAND := google
PRODUCT_DEVICE := panther
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Pixel 7
PRODUCT_NAME := aospa_panther

PRODUCT_GMS_CLIENTID_BASE := android-google

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_DEVICE=Pixel7 \
    PRIVATE_BUILD_DESC="panther-user 13 TD1A.221105.001 9104446 release-keys"

BUILD_FINGERPRINT := google/panther/panther:13/TD1A.221105.001/9104446:user/release-keys

$(call inherit-product, vendor/google_devices/panther/panther-vendor.mk)

endif
