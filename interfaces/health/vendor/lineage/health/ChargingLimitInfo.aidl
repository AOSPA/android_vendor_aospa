/*
 * Copyright (C) 2023-2025 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package vendor.lineage.health;

@JavaDerive(toString=true) @VintfStability
parcelable ChargingLimitInfo {
    int max;
    int min;
}
