package vendor.qti.qvirtvendor;

@VintfStability
enum VendorVMState {
    VM_NOT_STARTED = 0,
    VM_BOOT_READY = 1,
    VM_SHUTDOWN = 2,
    VM_USERSPACE_READY = 3,
    VM_TASK_INPROGRESS = 4,
    VM_CRASHED = 5,
}
