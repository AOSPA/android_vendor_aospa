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

# $(call is-kernel-greater-than-or-equal-to,kernel-version)
# Checks if the target kernel version is greater than or equal to
# the specified version.
#
# How it works:
#  1. We compare the major version of the target kernel version
#     with the major version of the target version.
#  2. If the majors are equal, we proceed to compare the minor version
#     of the target kernel version with the minor version
#     of the target version.
#  3. If both comparisons are true, it returns "true"; otherwise, it returns nothing.
define is-kernel-greater-than-or-equal-to
$(strip \
$(eval board_major:=$(firstword $(subst ., ,$(TARGET_KERNEL_VERSION)))) \
$(eval board_minor:=$(word 2,$(subst ., ,$(TARGET_KERNEL_VERSION)))) \
$(eval target_major:=$(firstword $(subst ., ,$(1)))) \
$(eval target_minor:=$(word 2,$(subst ., ,$(1)))) \
$(if $(filter $(board_major),$(target_major)),\
    $(if $(filter true,$(call math_gt_or_eq,$(board_minor),$(target_minor))),\
        true),\
    $(if $(filter true,$(call math_gt_or_eq,$(board_major),$(target_major))),\
        true))
)
endef

# $(call is-kernel-less-than-or-equal-to,kernel-version)
# Checks if the target kernel version is less than or equal to
# the specified version.
define is-kernel-less-than-or-equal-to
$(strip \
$(eval board_major:=$(firstword $(subst ., ,$(TARGET_KERNEL_VERSION)))) \
$(eval board_minor:=$(word 2,$(subst ., ,$(TARGET_KERNEL_VERSION)))) \
$(eval target_major:=$(firstword $(subst ., ,$(1)))) \
$(eval target_minor:=$(word 2,$(subst ., ,$(1)))) \
$(if $(filter $(board_major),$(target_major)),\
    $(if $(filter true,$(call math_lt_or_eq,$(board_minor),$(target_minor))),\
        true),\
    $(if $(filter true,$(call math_lt_or_eq,$(board_major),$(target_major))),\
        true))
)
endef

# $(call is-kernel-version-in-range,min_range,max_range)
# Checks if the target kernel is in range of the specified
# versions.
define is-kernel-version-in-range
$(and $(call is-kernel-greater-than-or-equal-to,$(1)), $(call is-kernel-less-than-or-equal-to,$(2)))
endef
