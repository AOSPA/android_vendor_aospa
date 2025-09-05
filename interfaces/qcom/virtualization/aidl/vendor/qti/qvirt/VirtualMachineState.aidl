package vendor.qti.qvirt;

@Backing(type="int")
@VintfStability
enum VirtualMachineState {
    NOT_STARTED = 0,
    RUNNING = 1,
    STOPPED = 2,
    VM_USERSPACE_READY = 3,
    VM_TASK_PROGRESS = 4,
    VM_CRASHED = 5,
}
