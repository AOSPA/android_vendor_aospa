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

#
# Handle various build version information.
#
# Guarantees that the following are defined:
#     AOSPA_MAJOR_VERSION
#     AOSPA_MINOR_VERSION
#     AOSPA_BUILD_VARIANT
#

# This is the global AOSPA version flavor that determines the focal point
# behind our releases. This is bundled alongside $(AOSPA_MINOR_VERSION)
# and only changes per major Android releases.
AOSPA_MAJOR_VERSION := uvite

# The version code is the upgradable portion during the cycle of
# every major Android release. Each version code upgrade indicates
# our own major release during each lifecycle.
# It is based in three parts
# X for SPL changes, Y for week, and Z for hotfix.
ifdef AOSPA_BUILDVERSION
    AOSPA_MINOR_VERSION := $(AOSPA_BUILDVERSION)
endif

# Build Variants
#
# Alpha: Development / Test releases
# Beta: Public releases with CI
# Stable: Final Product | No Tagging
ifdef AOSPA_BUILDTYPE
  ifeq ($(AOSPA_BUILDTYPE), ALPHA)
      AOSPA_BUILD_VARIANT := alpha
  else ifeq ($(AOSPA_BUILDTYPE), BETA)
      AOSPA_BUILD_VARIANT := beta
  else ifeq ($(AOSPA_BUILDTYPE), STABLE)
      AOSPA_BUILD_VARIANT := stable
  endif
else
  AOSPA_BUILD_VARIANT := unofficial
endif

# Build Date
BUILD_DATE := $(shell date -u +%Y%m%d)

# AOSPA Version
TMP_AOSPA_VERSION := $(AOSPA_MAJOR_VERSION)-
ifeq ($(filter stable,$(AOSPA_BUILD_VARIANT)),)
    TMP_AOSPA_VERSION += $(AOSPA_BUILD_VARIANT)-
else
    TMP_AOSPA_VERSION += $(AOSPA_MINOR_VERSION)-
endif

# Add BUILD_DATE for zip naming
AOSPA_VERSION := $(shell echo $(AOSPA_BUILD)-$(BUILD_DATE) | tr -d '[:space:]')

# Capitalized version of AOSPA version for Settings
RO_AOSPA_VERSION := $(shell echo $(TMP_AOSPA_VERSION) | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')

# The properties will be uppercase for parse by Settings, etc.
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.aospa.version=$(RO_AOSPA_VERSION) \
    ro.aospa.version.major=$(AOSPA_MAJOR_VERSION) \
    ro.aospa.version.minor=$(AOSPA_MINOR_VERSION) \
    ro.aospa.build.variant=$(AOSPA_BUILD_VARIANT)
