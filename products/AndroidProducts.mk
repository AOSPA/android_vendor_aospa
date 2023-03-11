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
    $(LOCAL_DIR)/alioth/aospa_alioth.mk \
    $(LOCAL_DIR)/apollo/aospa_apollo.mk \
    $(LOCAL_DIR)/beryllium/aospa_beryllium.mk \
    $(LOCAL_DIR)/bitra/aospa_bitra.mk \
    $(LOCAL_DIR)/bladerunner/aospa_bladerunner.mk \
    $(LOCAL_DIR)/bluejay/aospa_bluejay.mk \
    $(LOCAL_DIR)/cheetah/aospa_cheetah.mk \
    $(LOCAL_DIR)/dubai/aospa_dubai.mk \
    $(LOCAL_DIR)/lmi/aospa_lmi.mk \
    $(LOCAL_DIR)/mi439/aospa_mi439.mk \
    $(LOCAL_DIR)/miatoll/aospa_miatoll.mk \
    $(LOCAL_DIR)/mini5g/aospa_mini5g.mk \
    $(LOCAL_DIR)/oneplus5/aospa_oneplus5.mk \
    $(LOCAL_DIR)/oneplus5t/aospa_oneplus5t.mk \
    $(LOCAL_DIR)/oneplus9/aospa_oneplus9.mk \
    $(LOCAL_DIR)/oneplus9pro/aospa_oneplus9pro.mk \
    $(LOCAL_DIR)/oneplus9r/aospa_oneplus9r.mk \
    $(LOCAL_DIR)/oriole/aospa_oriole.mk \
    $(LOCAL_DIR)/panther/aospa_panther.mk \
    $(LOCAL_DIR)/phoenix/aospa_phoenix.mk \
    $(LOCAL_DIR)/phone1/aospa_phone1.mk \
    $(LOCAL_DIR)/raven/aospa_raven.mk \
    $(LOCAL_DIR)/spes/aospa_spes.mk

# Lunch targets
COMMON_LUNCH_CHOICES += \
    aospa_alioth-userdebug \
    aospa_apollo-userdebug \
    aospa_beryllium-userdebug \
    aospa_bitra-userdebug \
    aospa_bladerunner-userdebug \
    aospa_bluejay-userdebug \
    aospa_cheetah-userdebug \
    aospa_dubai-userdebug \
    aospa_lmi-userdebug \
    aospa_mi439-userdebug \
    aospa_miatoll-userdebug \
    aospa_mini5g-userdebug \
    aospa_oneplus5-userdebug \
    aospa_oneplus5t-userdebug \
    aospa_oneplus9-userdebug \
    aospa_oneplus9pro-userdebug \
    aospa_oneplus9r-userdebug \
    aospa_oriole-userdebug \
    aospa_panther-userdebug \
    aospa_phoenix-userdebug \
    aospa_phone1-userdebug \
    aospa_raven-userdebug \
    aospa_spes-userdebug
