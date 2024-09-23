///////////////////////////////////////////////////////////////////////////////
// THIS FILE IS IMMUTABLE. DO NOT EDIT IN ANY CASE.                          //
///////////////////////////////////////////////////////////////////////////////

// This file is a snapshot of an AIDL interface (or parcelable). Do not try to
// edit this file. It looks like you are doing that because you have modified
// an AIDL interface in a backward-incompatible way, e.g., deleting a function
// from an interface or a field from a parcelable and it broke the build. That
// breakage is intended.
//
// You must not make a backward incompatible changes to the AIDL files built
// with the aidl_interface module type with versions property set. The module
// type is used to build AIDL files in a way that they can be used across
// independently updatable components of the system. If a device is shipped
// with such a backward incompatible change, it has a high risk of breaking
// later when a module using the interface is updated, e.g., Mainline modules.

package vendor.aac.hardware.richtap.vibrator;
@VintfStability
interface IRichtapVibrator {
  oneway void init(in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  oneway void setDynamicScale(in int scale, in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  oneway void setF0(in int f0, in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  oneway void stop(in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  oneway void setAmplitude(in int amplitude, in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  oneway void performHeParam(in int interval, in int amplitude, in int freq, in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  oneway void off(in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  oneway void on(in int timeoutMs, in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  int perform(in int effect_id, in byte strength, in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  oneway void performEnvelope(in int[] envInfo, in boolean fastFlag, in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  oneway void performRtp(in ParcelFileDescriptor hdl, in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  oneway void performHe(in int looper, in int interval, in int amplitude, in int freq, in int[] he, in vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
}
