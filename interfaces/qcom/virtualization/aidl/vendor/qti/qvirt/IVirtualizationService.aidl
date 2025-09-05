package vendor.qti.qvirt;

import vendor.qti.qvirt.IVirtualMachine;

@VintfStability
interface IVirtualizationService {
    IVirtualMachine getVm(in @utf8InCpp String vmName);
}
