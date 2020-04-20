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


void sysFsRead(bool enabled, const char *file_node) {
    int fd, rc;
    fd = open(file_node, O_WRONLY);
    if (fd < 0) {
        ALOGE("Failed to open %s, %d", file_node, fd);
        return;
    }

    close(fd);
}

void sysFsWrite(bool enabled, const char *file_node) {
    int fd, rc;
    fd = open(file_node, O_WRONLY);
    if (fd < 0) {
        ALOGE("Failed to open %s, %d", file_node, fd);
        return;
    }

    rc = write(fd, enabled ? "1" : "0", 1);
    if (rc < 0) {
        ALOGE("Failed to write \"%d\" to %s", enabled, file_node);
    }

    close(fd);
}

ndk::ScopedAStatus PowerShare::isEnabled(bool enabled) {
    return sysFsRead(enabled, POWERSHARE_NODE);
}

ndk::ScopedAStatus PowerShare::setEnabled(bool enabled) {
    return sysFsWrite(enabled, POWERSHARE_NODE);
}

ndk::ScopedAStatus PowerShare::getMinBattery(int32_t minBattery) {
    return 0;
}

ndk::ScopedAStatus PowerShare::setMinBattery(int32_t minBattery) {
    return getMinBattery();
}

}  // namespace power
}  // namespace aospa
}  // namespace vendor
}  // namespace aidl
