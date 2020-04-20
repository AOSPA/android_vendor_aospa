/*
 * Copyright (C) 2023, Paranoid Android
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "vendor.aospa.powershare-service"
// #define LOG_NDEBUG 0

#include "PowerShare.h"

#include <android-base/file.h>
#include <fcntl.h>
#include <log/log.h>
#include <unistd.h>

using ::android::base::ReadFileToString;
using ::android::base::WriteStringToFile;

namespace aidl {
namespace vendor {
namespace aospa {
namespace powershare {


void sysFsRead(bool* enabled, const char *file_node) {
    int fd, rc;
    fd = open(file_node, O_WRONLY);
    if (fd < 0) {
        ALOGE("Failed to open %s, %d", file_node, fd);
        return;
    }
    // TODO: read
    close(fd);
}

bool sysFsWrite(bool enabled, const char *file_node) {
    int fd, rc;
    fd = open(file_node, O_WRONLY);
    if (fd < 0) {
        ALOGE("Failed to open %s, %d", file_node, fd);
        return false;
    }

    rc = write(fd, enabled ? "1" : "0", 1);
    if (rc < 0) {
        ALOGE("Failed to write \"%d\" to %s", enabled, file_node);
        return false;
    }

    close(fd);
    return true;
}

ndk::ScopedAStatus PowerShare::isEnabled(bool* _aidl_return) {
    sysFsRead(_aidl_return, POWERSHARE_NODE);
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus PowerShare::setEnabled(bool in_enable, bool* _aidl_return) {
    *_aidl_return = sysFsWrite(in_enable, POWERSHARE_NODE);
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus PowerShare::getMinBattery(int32_t* _aidl_return) {
    *_aidl_return = 0;
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus PowerShare::setMinBattery(int32_t in_minBattery, int32_t* _aidl_return) {
    return getMinBattery(_aidl_return);
}

}  // namespace power
}  // namespace aospa
}  // namespace vendor
}  // namespace aidl
