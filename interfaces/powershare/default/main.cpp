/*
 * SPDX-FileCopyrightText: Paranoid Android
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_TAG "vendor.aospa.powershare-service"

#include <android-base/logging.h>
#include <android/binder_manager.h>
#include <android/binder_process.h>

#include "PowerShare.h"

using ::aidl::vendor::aospa::powershare::PowerShare;

int main() {
    ABinderProcess_setThreadPoolMaxThreadCount(0);
    std::shared_ptr<PowerShare> powerShare = ndk::SharedRefBase::make<PowerShare>();
    if (!powerShare) {
        return EXIT_FAILURE;
    }

    const std::string instance = std::string(PowerShare::descriptor) + "/default";
    binder_status_t status =
            AServiceManager_addService(powerShare->asBinder().get(), instance.c_str());
    CHECK(status == STATUS_OK);

    ABinderProcess_joinThreadPool();
    return EXIT_FAILURE; // should not reached
}
