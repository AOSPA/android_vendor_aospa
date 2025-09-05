package vendor.qti.qvirtvendor;

import vendor.qti.qvirtvendor.VendorVMState;
import vendor.qti.qvirtvendor.VMErrorCodes;
import vendor.qti.qvirtvendor.VMInfo;
import vendor.qti.qvirtvendor.VMTasks;

@VintfStability
interface IVendorVM {
    VendorVMState getState(in VMInfo vminfo);
    VMErrorCodes connectvm(in VMInfo vminfo);
    VMErrorCodes disconnectvm(in VMInfo vminfo);
    VMErrorCodes performtaskvm(in VMInfo vminfo, in VMTasks task);
}
