package vendor.aac.hardware.richtap.vibrator;

@VintfStability
interface IRichtapCallback {
    oneway void onCallback(in int value);
}