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
#  1. We compare the first word (major version) of the target kernel version
#     with the first word of the specified version.
#  2. If the first words are equal, we proceed to compare the second word
#     (minor version) of the target kernel version with the second word
#     of the specified version.
#  3. If both comparisons are true, it returns "true"; otherwise, it returns "false."
define is-kernel-greater-than-or-equal-to
$(strip $(if $(filter $(firstword ,$(subst ., ,$(TARGET_KERNEL_VERSION))),$(firstword ,$(subst ., ,$(1)))),\
    $(if $(filter true,$(call math_gt_or_eq,$(word 2,$(subst ., ,$(TARGET_KERNEL_VERSION))),$(word 2,$(subst ., ,$(1))))),\
        true,\
        false),\
    $(if $(filter true,$(call math_gt_or_eq,$(firstword $(subst ., ,$(TARGET_KERNEL_VERSION))),$(firstword $(subst ., ,$(1))))),\
        true,\
        false)))
endef
