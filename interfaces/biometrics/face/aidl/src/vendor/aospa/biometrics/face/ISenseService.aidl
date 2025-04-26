/*
 * SPDX-FileCopyrightText: Paranoid Android
 * SPDX-License-Identifier: Apache-2.0
 */

package vendor.aospa.biometrics.face;

import vendor.aospa.biometrics.face.ISenseServiceReceiver;

/** @hide */
interface ISenseService {
    oneway void authenticate(long operationId);

    oneway void cancel();

    oneway void enroll(in byte[] cryptoToken, int timeout, in int[] disabledFeatures);

    int enumerate();

    long generateChallenge(int timeout);

    int getAuthenticatorId();

    oneway void remove(int biometricId);

    oneway void resetLockout(in byte[] cryptoToken);

    int revokeChallenge();

    oneway void setCallback(in ISenseServiceReceiver receiver);

    int getFeatureCount();

    boolean getFeature(int feature, int faceId);

    oneway void setFeature(int feature, boolean enable, in byte[] token, int faceId);
}
