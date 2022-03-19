#
# Copyright (C) 2022 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# Bootanimation
ifneq ($(filter $(TARGET_BOOT_ANIMATION_RES),720 1080 1440 2160),)
    PRODUCT_COPY_FILES += vendor/aospa/bootanimation/$(TARGET_BOOT_ANIMATION_RES)/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else
    $(error "Invalid bootanimation resolution: $(TARGET_BOOT_ANIMATION_RES). Define TARGET_BOOT_ANIMATION_RES to 720/1080/1440/2160.")
endif
