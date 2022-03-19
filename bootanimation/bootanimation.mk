#
# Copyright (C) 2022 Paranoid Android
#
# SPDX-License-Identifier: Apache-2.0
#

# Bootanimation
TARGET_BOOT_ANIMATION_RES := $(strip $(TARGET_BOOT_ANIMATION_RES))

ifeq ($(TARGET_BOOT_ANIMATION_RES),)
    $(error "TARGET_BOOT_ANIMATION_RES is undefined, Define any from 720/1080/1440/2160")
else
    ifneq ($(filter $(TARGET_BOOT_ANIMATION_RES),720 1080 1440 2160),)
        PRODUCT_COPY_FILES += vendor/aospa/bootanimation/$(TARGET_BOOT_ANIMATION_RES)/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
    else
        $(warning "Invalid bootanimation resolution: $(TARGET_BOOT_ANIMATION_RES). Defaulting to 1080p.")
        PRODUCT_COPY_FILES += vendor/aospa/bootanimation/1080/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
    endif
endif
