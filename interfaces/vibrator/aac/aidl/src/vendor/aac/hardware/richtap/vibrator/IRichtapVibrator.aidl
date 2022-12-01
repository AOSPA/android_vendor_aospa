/**
 * Copyright (C) 2022 Paranoid Android
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

package vendor.aac.hardware.richtap.vibrator;

import vendor.aac.hardware.richtap.vibrator.IRichtapCallback;

/** @hide */
interface IRichtapVibrator {
    String getInterfaceHash();

    int getInterfaceVersion();

    oneway void init(IRichtapCallback callback);

    oneway void off(IRichtapCallback callback);

    oneway void on(int timeoutMs, IRichtapCallback callback);

    int perform(int effect_id, byte strength, IRichtapCallback callback);

    oneway void performEnvelope(int[] envInfo, boolean fastFlag, IRichtapCallback callback);

    oneway void performHe(int looper, int interval, int amplitude, int freq, int[] he, IRichtapCallback callback) ;

    oneway void performHeParam(int interval, int amplitude, int freq, IRichtapCallback callback);

    oneway void performRtp(ParcelFileDescriptor descriptor, IRichtapCallback callback);

    oneway void setAmplitude(int amplitude, IRichtapCallback callback);

    oneway void setDynamicScale(int scale, IRichtapCallback callback);

    oneway void setF0(int f0, IRichtapCallback callback);

    oneway void stop(IRichtapCallback callback);

}
