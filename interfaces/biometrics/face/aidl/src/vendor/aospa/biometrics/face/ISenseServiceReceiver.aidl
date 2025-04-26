/*
 * SPDX-FileCopyrightText: Paranoid Android
 * SPDX-License-Identifier: Apache-2.0
 */

package vendor.aospa.biometrics.face;

/** @hide */
oneway interface ISenseServiceReceiver {
    void onEnrollResult(int faceId, int userId, int remaining);

    void onAuthenticated(int faceId, int userId, in byte[] token);

    void onAcquired(int userId, int acquiredInfo, int vendorCode);

    void onError(int error, int vendorCode);

    void onRemoved(in int[] faceIds, int userId);

    void onEnumerate(in int[] faceIds, int userId);

    void onLockoutChanged(long duration);
}
