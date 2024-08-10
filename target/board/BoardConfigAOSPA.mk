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

# Dex2oat
ifeq ($(TARGET_CPU_VARIANT),cortex-a510)
    DEX2OAT_TARGET_CPU_VARIANT := cortex-a76
    DEX2OAT_TARGET_CPU_VARIANT_RUNTIME := cortex-a76
endif

ifeq ($(call is-board-platform-in-list,$(QCOM_BOARD_PLATFORMS)),true)
# Include our Qualcomm Board configuration.
include device/qcom/common/BoardConfigQcom.mk
endif

# Include our private configuration - optional.
-include vendor/aospa-priv/target/board/BoardConfigAOSPAPriv.mk

# Kernel configuration.
include vendor/aospa/target/board/BoardConfigKernel.mk

# Soong
include vendor/aospa/target/board/BoardConfigSoong.mk
