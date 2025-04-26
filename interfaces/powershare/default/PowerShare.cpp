/*
 * SPDX-FileCopyrightText: Paranoid Android
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef POWERSHARE_NODE
#pragma GCC error "Must define POWERSHARE_NODE!"
#endif

#define LOG_TAG "vendor.aospa.powershare-service"

#include "PowerShare.h"

#include <android-base/file.h>
#include <android-base/strings.h>
#include <fstream>
#include <log/log.h>

using ::android::base::ReadFileToString;
using ::android::base::WriteStringToFile;

namespace aidl {
namespace vendor {
namespace aospa {
namespace powershare {

ndk::ScopedAStatus PowerShare::isEnabled(bool* _aidl_return) {
    std::string content;
    ReadFileToString(POWERSHARE_NODE, &content);
    content = android::base::Trim(content);
    *_aidl_return = content == "1";
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus PowerShare::setEnabled(bool in_enable, bool* _aidl_return) {
    WriteStringToFile((in_enable ? "1" : "0"), POWERSHARE_NODE);
    *_aidl_return = in_enable;
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus PowerShare::getMinBattery(int32_t* _aidl_return) {
    *_aidl_return = 0;
    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus PowerShare::setMinBattery(int32_t in_minBattery, int32_t* _aidl_return) {
    return getMinBattery(_aidl_return);
}

}  // namespace powershare
}  // namespace aospa
}  // namespace vendor
}  // namespace aidl
