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

# Disable EAP Proxy because it depends on proprietary headers
# and breaks WPA Supplicant compilation.
DISABLE_EAP_PROXY := true

# Include our Qualcomm Board configuration.
include device/qcom/common/BoardConfigQcom.mk

# Kernel configuration.
ifeq ($(BOARD_USES_LINEAGE_KERNEL_BUILDER),true)
include vendor/aospa/target/board/BoardConfigKernelLineage.mk
else
include vendor/aospa/target/board/BoardConfigKernel.mk
endif

# Soong
include vendor/aospa/target/board/BoardConfigSoong.mk
