package vendor.aac.hardware.richtap.vibrator;

import android.os.ParcelFileDescriptor;
import vendor.aac.hardware.richtap.vibrator.IRichtapCallback;

@VintfStability
interface IRichtapVibrator {
    void init(IRichtapCallback callback);

    void setDynamicScale(int scale, IRichtapCallback callback);

    void setF0(int f0, IRichtapCallback callback);

    void stop(IRichtapCallback callback);

    void setAmplitude(int amplitude, IRichtapCallback callback);

    void performHeParam(int interval, int amplitude, int freq, IRichtapCallback callback);

    void off(IRichtapCallback callback);

    void on(int duration, IRichtapCallback callback);

    int perform(int effect, byte enable, IRichtapCallback callback);

    void performEnvelope(in int[] envInfo, boolean fastFlag, IRichtapCallback callback);

    void performRtp(in ParcelFileDescriptor file, IRichtapCallback callback);

    void performHe(int looper, int interval, int amplitude, int freq, in int[] data, IRichtapCallback callback);
}