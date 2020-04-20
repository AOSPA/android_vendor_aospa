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

#ifndef POWERSHARE_NODE
#pragma GCC error "Must define POWERSHARE_NODE!"
#endif

#define LOG_TAG "vendor.aospa.powershare-service"

#include "PowerShare.h"

#include <android-base/file.h>
#include <fstream>
#include <log/log.h>

using ::android::base::ReadFileToString;
using ::android::base::WriteStringToFile;

namespace aidl {
namespace vendor {
namespace aospa {
namespace powershare {

void sysFsRead(bool* enabled, std::string file_node, const bool def) {
    std::ifstream file(file_node);
    bool result;

    file >> result;
    *enabled = file.fail() ? def : result;
}

bool sysFsWrite(bool enabled, std::string file_node) {
    std::ofstream file(file_node);
    file << (enabled ? 1 : 0);
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
