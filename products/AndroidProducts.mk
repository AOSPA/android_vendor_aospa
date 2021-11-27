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

# Product Makefiles
PRODUCT_MAKEFILES += \
    $(LOCAL_DIR)/oneplus9/aospa_oneplus9.mk \
    $(LOCAL_DIR)/oneplus9pro/aospa_oneplus9pro.mk \
    $(LOCAL_DIR)/beryllium/aospa_beryllium.mk \
    $(LOCAL_DIR)/dipper/aospa_dipper.mk \
    $(LOCAL_DIR)/equuleus/aospa_equuleus.mk \
    $(LOCAL_DIR)/perseus/aospa_perseus.mk \
    $(LOCAL_DIR)/polaris/aospa_polaris.mk \
    $(LOCAL_DIR)/ursa/aospa_ursa.mk

# Lunch targets
COMMON_LUNCH_CHOICES += \
    aospa_oneplus9-userdebug \
    aospa_oneplus9pro-userdebug \
    aospa_beryllium-userdebug \
    aospa_dipper-userdebug \
    aospa_equuleus-userdebug \
    aospa_perseus-userdebug \
    aospa_polaris-userdebug \
    aospa_ursa-userdebug
