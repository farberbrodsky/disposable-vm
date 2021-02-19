source config.sh
source ./util/get_port.sh

echo ssh on port $port
qemu-kvm -m $MEMORY -nographic -smp $CPU_CORES -drive file=image.qcow2,format=qcow2 \
-device e1000,netdev=net0 \
-netdev user,id=net0,hostfwd=tcp::$port-:22 > /dev/null &
qemu_pid=$!

# try to ssh until it connects
while true
do
    ssh -q -o StrictHostKeyChecking=no -o ConnectTimeout=1 localhost -p $port
    # if the server closes, stop
    if ! (stat /proc/$qemu_pid/cmdline >/dev/null 2>/dev/null); then
        exit
    fi
done
