/*
 * SPDX-FileCopyrightText: Paranoid Android
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#include <aidl/vendor/aospa/powershare/BnPowerShare.h>

namespace aidl {
namespace vendor {
namespace aospa {
namespace powershare {

class PowerShare : public BnPowerShare {
    public:
      ndk::ScopedAStatus isEnabled(bool* _aidl_return) override;
      ndk::ScopedAStatus setEnabled(bool enable, bool* _aidl_return) override;
      ndk::ScopedAStatus getMinBattery(int32_t* _aidl_return) override;
      ndk::ScopedAStatus setMinBattery(int32_t in_minBattery, int32_t* _aidl_return) override;
};

}  // namespace powershare
}  // namespace aospa
}  // namespace vendor
}  // namespace aidl
