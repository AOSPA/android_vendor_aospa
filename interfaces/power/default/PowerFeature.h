/*
 * SPDX-FileCopyrightText: Paranoid Android
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#include <aidl/vendor/aospa/power/BnPowerFeature.h>
#include <linux/input.h>

namespace aidl {
namespace vendor {
namespace aospa {
namespace power {

class PowerFeature : public BnPowerFeature {
    public:
      ndk::ScopedAStatus setFeature(Feature feature, bool enabled) override;

    protected:
      void sysFsWrite(const char *file_node, bool enabled);
      void sysFsWrite(const char *file_node, const input_event *ev);
};

}  // namespace power
}  // namespace aospa
}  // namespace vendor
}  // namespace aidl
