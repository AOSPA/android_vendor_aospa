package vendor.qti.qvirt;

import vendor.qti.qvirt.IVirtualMachineCallback;
import vendor.qti.qvirt.VirtualMachineClientTask;
import vendor.qti.qvirt.VirtualMachineState;

@VintfStability
interface IVirtualMachine {
    const int ERROR_VM_START = -1;
    VirtualMachineState getState();
    void registerCallback(IVirtualMachineCallback callback);
    void start();
    void performtask_client(in VirtualMachineClientTask task);
    void unregister();
}
