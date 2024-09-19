package vendor.qti.hardware.fm;

import vendor.qti.hardware.fm.IFmHciCallbacks;

@VintfStability
interface IFmHci {
    void close();
    void initialize(in IFmHciCallbacks callback);
    void sendHciCommand(in byte[] command);
}
