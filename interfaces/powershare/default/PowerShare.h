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
