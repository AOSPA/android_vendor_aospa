/*
 * Copyright (C) 2022-2023 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include "ChargingControl.h"

#include <android-base/file.h>
#include <android-base/logging.h>
#include <android-base/parseint.h>
#include <android-base/strings.h>
#include <android/binder_status.h>
#include <fstream>
#include <inttypes.h>
#include "android/binder_auto_utils.h"

#define LOG_TAG "vendor.lineage.health-service.default"

namespace aidl {
namespace vendor {
namespace lineage {
namespace health {

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE
static const std::vector<ChargingEnabledNode> kChargingEnabledNodes = {
#ifdef HEALTH_CHARGING_CONTROL_CHARGING_PATH
        {HEALTH_CHARGING_CONTROL_CHARGING_PATH,
         HEALTH_CHARGING_CONTROL_CHARGING_ENABLED,
         HEALTH_CHARGING_CONTROL_CHARGING_DISABLED,
         {}},
#else
        {"/sys/class/power_supply/battery/battery_charging_enabled", "1", "0",
         static_cast<int>(ChargingControlSupportedMode::TOGGLE) |
                 static_cast<int>(ChargingControlSupportedMode::BYPASS)},
        {"/sys/class/power_supply/battery/charging_enabled", "1", "0",
         static_cast<int>(ChargingControlSupportedMode::TOGGLE) |
                 static_cast<int>(ChargingControlSupportedMode::BYPASS)},
        {"/sys/class/power_supply/battery/input_suspend", "0", "1",
         static_cast<int>(ChargingControlSupportedMode::TOGGLE)},
        {"/sys/class/qcom-battery/input_suspend", "0", "1",
         static_cast<int>(ChargingControlSupportedMode::TOGGLE)},
#endif
};
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE
static const std::vector<std::string> kChargingDeadlineNodes = {
        HEALTH_CHARGING_CONTROL_DEADLINE_PATH,
        "/sys/class/power_supply/battery/charge_deadline",
};
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT
static const std::vector<std::string> kChargingLimitNodes = {
    HEALTH_CHARGING_CONTROL_LIMIT_PATH,
    "/sys/class/power_supply/battery/charge_limit",
};
#endif

#define OPEN_RETRY_COUNT 10

ChargingControl::ChargingControl()
    : mChargingEnabledNode(nullptr), mChargingDeadlineNode(nullptr), mChargingLimitNode(nullptr) {
#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE
    while (!mChargingEnabledNode) {
        for (const auto& node : kChargingEnabledNodes) {
            for (int retries = 0; retries < OPEN_RETRY_COUNT; retries++) {
                if (access(node.path.c_str(), R_OK | W_OK) == 0) {
                    mChargingEnabledNode = &node;
                    return;
                }
                PLOG(WARNING) << "Failed to access() file " << node.path;
                usleep(10000);
            }
        }
    }
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE
    while (!mChargingDeadlineNode) {
        for (const auto& node : kChargingDeadlineNodes) {
            for (int retries = 0; retries < OPEN_RETRY_COUNT; retries++) {
                if (access(node.c_str(), R_OK | W_OK) == 0) {
                    mChargingDeadlineNode = &node;
                    break;
                }
                PLOG(WARNING) << "Failed to access() file " << node;
                usleep(100000);
            }
        }
    }
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT
    while (!mChargingLimitNode) {
        for (const auto& node : kChargingLimitNodes) {
            if (access(node.path.c_str(), R_OK | W_OK) == 0) {
                mChargingLimitNode = &node;
                break;
            }
            PLOG(WARNING) << "Failed to access() file " << node.path;
            usleep(100000);
        }
    }
#endif
}

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE
ndk::ScopedAStatus ChargingControl::getChargingEnabled(bool* _aidl_return) {
    std::string content;
    if (!android::base::ReadFileToString(mChargingEnabledNode->path, &content, true)) {
        LOG(ERROR) << "Failed to read current charging enabled value";
        return ndk::ScopedAStatus::fromExceptionCode(EX_ILLEGAL_STATE);
    }

    content = android::base::Trim(content);

    if (content == mChargingEnabledNode->value_true) {
        *_aidl_return = true;
    } else if (content == mChargingEnabledNode->value_false) {
        *_aidl_return = false;
    } else {
        LOG(ERROR) << "Unknown value " << content;
        return ndk::ScopedAStatus::fromExceptionCode(EX_ILLEGAL_STATE);
    }

    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus ChargingControl::setChargingEnabled(bool enabled) {
    const auto& value =
            enabled ? mChargingEnabledNode->value_true : mChargingEnabledNode->value_false;
    if (!android::base::WriteStringToFile(value, mChargingEnabledNode->path, true)) {
        LOG(ERROR) << "Failed to write to charging enable node: " << strerror(errno);
        return ndk::ScopedAStatus::fromExceptionCode(EX_ILLEGAL_STATE);
    }

    return ndk::ScopedAStatus::ok();
}
#else
ndk::ScopedAStatus ChargingControl::getChargingEnabled(bool* /* _aidl_return */) {
    return ndk::ScopedAStatus::fromExceptionCode(EX_UNSUPPORTED_OPERATION);
}

ndk::ScopedAStatus ChargingControl::setChargingEnabled(bool /* enabled */) {
    return ndk::ScopedAStatus::fromExceptionCode(EX_UNSUPPORTED_OPERATION);
}
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE
ndk::ScopedAStatus ChargingControl::setChargingDeadline(int64_t deadline) {
    std::string content = std::to_string(deadline);
    if (!android::base::WriteStringToFile(content, *mChargingDeadlineNode, true)) {
        LOG(ERROR) << "Failed to write to charging deadline node: " << strerror(errno);
        return ndk::ScopedAStatus::fromExceptionCode(EX_ILLEGAL_STATE);
    }

    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus ChargingControl::getChargingDeadline(int64_t* _aidl_return) {
    std::string content;
    if (!android::base::ReadFileToString(*mChargingDeadlineNode, &content, true)) {
        LOG(ERROR) << "Failed to read current charging deadline value";
        return ndk::ScopedAStatus::fromExceptionCode(EX_ILLEGAL_STATE);
    }

    content = android::base::Trim(content);

    return android::base::ParseInt<int64_t>(content, _aidl_return)
                   ? ndk::ScopedAStatus::ok()
                   : ndk::ScopedAStatus::fromExceptionCode(EX_ILLEGAL_STATE);
}
#else
ndk::ScopedAStatus ChargingControl::setChargingDeadline(int64_t /* deadline */) {
    return ndk::ScopedAStatus::fromExceptionCode(EX_UNSUPPORTED_OPERATION);
}

ndk::ScopedAStatus ChargingControl::getChargingDeadline(int64_t* /* _aidl_return */) {
    return ndk::ScopedAStatus::fromExceptionCode(EX_UNSUPPORTED_OPERATION);
}
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT
ndk::ScopedAStatus ChargingControl::setChargingLimit(int limit) {
    std::string content = std::to_string(limit);
    if (!android::base::WriteStringToFile(content, *mChargingLimitNode, true)) {
        LOG(ERROR) << "Failed to write to charging limit node: " << strerror(errno);
        return ndk::ScopedAStatus::fromExceptionCode(EX_ILLEGAL_STATE);
    }

    return ndk::ScopedAStatus::ok();
}

ndk::ScopedAStatus ChargingControl::getChargingLimit(int* _aidl_return) {
    std::string content;
    if (!android::base::ReadFileToString(*mChargingLimitNode, &content, true)) {
        LOG(ERROR) << "Failed to read current charging limit value";
        return ndk::ScopedAStatus::fromExceptionCode(EX_ILLEGAL_STATE);
    }

    content = android::base::Trim(content);

    return android::base::ParseInt(content, _aidl_return)
                   ? ndk::ScopedAStatus::ok()
                   : ndk::ScopedAStatus::fromExceptionCode(EX_ILLEGAL_STATE);
}
#else
ndk::ScopedAStatus ChargingControl::setChargingLimit(const ::aidl::vendor::lineage::health::ChargingLimitInfo& in_limit) {
    return ndk::ScopedAStatus::fromExceptionCode(EX_UNSUPPORTED_OPERATION);
}

ndk::ScopedAStatus ChargingControl::getChargingLimit(::aidl::vendor::lineage::health::ChargingLimitInfo* _aidl_return) {
    return ndk::ScopedAStatus::fromExceptionCode(EX_UNSUPPORTED_OPERATION);
}
#endif

ndk::ScopedAStatus ChargingControl::getSupportedMode(int* _aidl_return) {
    int mode = 0;

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE
    mode |= static_cast<int>(ChargingControlSupportedMode::TOGGLE);
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS
    mode |= static_cast<int>(ChargingControlSupportedMode::BYPASS);
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE
    mode |= static_cast<int>(ChargingControlSupportedMode::DEADLINE);
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE
    *_aidl_return = mChargingEnabledNode->supported_mode.value_or(mode);
#else
    *_aidl_return = mode;
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT
    mode |= static_cast<int>(ChargingControlSupportedMode::LIMIT);
#endif

    return ndk::ScopedAStatus::ok();
}

binder_status_t ChargingControl::dump(int fd, const char** /* args */, uint32_t /* numArgs */) {
    int supportedMode;
    getSupportedMode(&supportedMode);

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE
    bool isChargingEnabled;
    getChargingEnabled(&isChargingEnabled);
    dprintf(fd, "Charging control node selected: %s\n", mChargingEnabledNode->path.c_str());
    dprintf(fd, "Charging enabled: %s\n", isChargingEnabled ? "true" : "false");
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE
    int64_t chargingDeadline;
    getChargingDeadline(&chargingDeadline);
    dprintf(fd, "Charging deadline node selected: %s\n", mChargingDeadlineNode->c_str());
    dprintf(fd, "Charging deadline(seconds): %" PRId64 "\n", chargingDeadline);
#endif

#ifdef HEALTH_CHARGING_CONTROL_SUPPORTS_LIMIT
    int chargingLimit;
    getChargingLimit(&chargingLimit);
    dprintf(fd, "Charging limit node selected: %s\n", mChargingLimitNode->c_str());
    dprintf(fd, "Charging limit: %d\n", chargingLimit);
#endif

    dprintf(fd, "Charging control supported mode: %d\n", supportedMode);

    return STATUS_OK;
}

}  // namespace health
}  // namespace lineage
}  // namespace vendor
}  // namespace aidl
