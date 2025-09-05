package vendor.qti.qvirt;

import vendor.qti.qvirt.VirtualMachineState;

@VintfStability
oneway interface IVirtualMachineCallback {
    void onStatusChanged(in VirtualMachineState vmState);
}
