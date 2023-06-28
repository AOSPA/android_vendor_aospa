/*
 * Copyright (C) 2023-2025 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package vendor.lineage.health;

import vendor.lineage.health.FastChargeMode;

@VintfStability
interface IFastCharge {
    /**
     * Get supported fast charging modes.
     *
     * @return A bitmap of upported fast charging modes, specified by {@link FastChargeMode}
     *         If error:
     *         - Return service specific error with code STATUS_UNKNOWN
     */
    long getSupportedFastChargeModes();

    /**
     * Get the fast charging mode.
     *
     * @return Current fast charging mode, specified by {@link FastChargeMode}
     *         If error:
     *         - Return service specific error with code STATUS_UNKNOWN
     */
    FastChargeMode getFastChargeMode();

    /**
     * Set the fast charging mode.
     *
     * @return Current fast charging mode, specified by {@link FastChargeMode}
     *         If error:
     *         - Return exception with code EX_ILLEGAL_STATE
     *           if the value can't be determined from the driver.
     *         - Return service specific error with code STATUS_UNKNOWN
     *           for other errors.
     */
    FastChargeMode setFastChargeMode(FastChargeMode mode);
}
