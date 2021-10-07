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
    $(LOCAL_DIR)/mini5g/aospa_mini5g.mk \
    $(LOCAL_DIR)/oneplus8/aospa_oneplus8.mk \
    $(LOCAL_DIR)/oneplus8pro/aospa_oneplus8pro.mk \
    $(LOCAL_DIR)/oneplus8t/aospa_oneplus8t.mk \
    $(LOCAL_DIR)/oneplus9/aospa_oneplus9.mk \
    $(LOCAL_DIR)/oneplus9pro/aospa_oneplus9pro.mk

# Lunch targets
COMMON_LUNCH_CHOICES += \
    aospa_mini5g-userdebug \
    aospa_oneplus8-userdebug \
    aospa_oneplus8pro-userdebug \
    aospa_oneplus8t-userdebug \
    aospa_oneplus9-userdebug \
    aospa_oneplus9pro-userdebug
