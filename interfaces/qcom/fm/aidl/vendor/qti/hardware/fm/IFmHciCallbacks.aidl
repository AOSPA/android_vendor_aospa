package vendor.qti.hardware.fm;

import vendor.qti.hardware.fm.Status;

@VintfStability
interface IFmHciCallbacks {
    void hciEventReceived(in byte[] event);
    void initializationComplete(in Status status);
}
