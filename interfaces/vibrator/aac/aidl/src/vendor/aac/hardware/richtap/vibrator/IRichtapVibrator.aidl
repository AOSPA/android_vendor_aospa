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

    oneway void init(in IRichtapCallback callback);

    oneway void off(in IRichtapCallback callback);

    oneway void on(int timeoutMs, in IRichtapCallback callback);

    int perform(int effect_id, byte strength, in IRichtapCallback callback);

    oneway void performEnvelope(in int[] envInfo, boolean fastFlag, in IRichtapCallback callback);

    oneway void performHe(int looper, int interval, int amplitude, int freq, in int[] he, in IRichtapCallback callback) ;

    oneway void performHeParam(int interval, int amplitude, int freq, in IRichtapCallback callback);

    oneway void performRtp(in ParcelFileDescriptor descriptor, in IRichtapCallback callback);

    oneway void setAmplitude(int amplitude, in IRichtapCallback callback);

    oneway void setDynamicScale(int scale, in IRichtapCallback callback);

    oneway void setF0(int f0, in IRichtapCallback callback);

    oneway void stop(in IRichtapCallback callback);

}
