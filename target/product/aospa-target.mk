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

# AOSPA Versioning.
$(call inherit-product, vendor/aospa/target/product/version.mk)

# Don't dexpreopt prebuilts. (For GMS).
DONT_DEXPREOPT_PREBUILTS := true

# Include Common Qualcomm Device Tree.
$(call inherit-product, device/qcom/common/common.mk)

# Include definitions for Snapdragon Clang
$(call inherit-product, vendor/qcom/sdclang/SnapdragonClang.mk)

# Include Packages makefile.
$(call inherit-product, vendor/aospa/target/product/packages.mk)

# Include Properties makefile.
$(call inherit-product, vendor/aospa/target/product/properties.mk)

# Include GMS, Modules, and Pixel features.
$(call inherit-product, vendor/google/gms/config.mk)
$(call inherit-product-if-exists, vendor/google/modules/build/mainline_modules_r.mk)
$(call inherit-product, vendor/google/pixel/config.mk)

# Move Wi-Fi modules to vendor.
PRODUCT_VENDOR_MOVE_ENABLED := true
