source config.sh
source ./util/get_port.sh

new_img=$port.qcow2
cp image.qcow2 $new_img

echo ssh on port $port, filename $new_img
qemu-kvm -m $MEMORY -nographic -smp $CPU_CORES -drive file=$new_img,format=qcow2 \
-device e1000,netdev=net0 \
-netdev user,id=net0,hostfwd=tcp::$port-:22 > /dev/null &
qemu_pid=$!

# try to ssh until it connects
while true
do
    ssh -q -o StrictHostKeyChecking=no -o ConnectTimeout=1 localhost -p $port
    # if the server closes, stop
    if ! (stat /proc/$qemu_pid/cmdline >/dev/null 2>/dev/null); then
        rm $new_img
        exit
    fi
done
