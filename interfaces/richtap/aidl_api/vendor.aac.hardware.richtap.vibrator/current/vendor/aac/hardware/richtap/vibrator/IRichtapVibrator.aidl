///////////////////////////////////////////////////////////////////////////////
// THIS FILE IS IMMUTABLE. DO NOT EDIT IN ANY CASE.                          //
///////////////////////////////////////////////////////////////////////////////

// This file is a snapshot of an AIDL file. Do not edit it manually. There are
// two cases:
// 1). this is a frozen version file - do not edit this in any case.
// 2). this is a 'current' file. If you make a backwards compatible change to
//     the interface (from the latest frozen version), the build system will
//     prompt you to update this file with `m <name>-update-api`.
//
// You must not make a backward incompatible change to any AIDL file built
// with the aidl_interface module type with versions property set. The module
// type is used to build AIDL files in a way that they can be used across
// independently updatable components of the system. If a device is shipped
// with such a backward incompatible change, it has a high risk of breaking
// later when a module using the interface is updated, e.g., Mainline modules.

package vendor.aac.hardware.richtap.vibrator;
@VintfStability
interface IRichtapVibrator {
  void init(vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  void setDynamicScale(int scale, vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  void setF0(int f0, vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  void stop(vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  void setAmplitude(int amplitude, vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  void performHeParam(int interval, int amplitude, int freq, vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  void off(vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  void on(int duration, vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  int perform(int effect, byte enable, vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  void performEnvelope(in int[] envInfo, boolean fastFlag, vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  void performRtp(in ParcelFileDescriptor file, vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
  void performHe(int looper, int interval, int amplitude, int freq, in int[] data, vendor.aac.hardware.richtap.vibrator.IRichtapCallback callback);
}
