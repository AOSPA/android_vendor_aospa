/*
 * SPDX-FileCopyrightText: Paranoid Android
 * SPDX-License-Identifier: Apache-2.0
 */

package vendor.aospa.power;

import vendor.aospa.power.Feature;

@VintfStability
interface IPowerFeature {
    oneway void setFeature(Feature feature, boolean enabled);
}
