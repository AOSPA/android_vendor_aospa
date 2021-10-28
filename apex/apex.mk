# Copyright (C) 2016-2021 Paranoid Android
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

# Packages
ifeq ($(TARGET_BOOT_ANIMATION_RES),)
$(error "TARGET_BOOT_ANIMATION_RES is not defined yet, please define in your product makefile to access AOSPA bootanimation apex.")
else
PRODUCT_PACKAGES += \
    com.android.bootanimation-$(TARGET_BOOT_ANIMATION_RES)
endif
