MEMORY=4096M
CPU_CORES=2

# find available port
port=$((netstat --listening --all --tcp --numeric | 
    sed '1,2d; s/[^[:space:]]*[[:space:]]*[^[:space:]]*[[:space:]]*[^[:space:]]*[[:space:]]*[^[:space:]]*:\([0-9]*\)[[:space:]]*.*/\1/g' |
    sort -n | uniq; seq 1 1024; seq 1 65535
) | sort -n | uniq -u | shuf -n 1)

echo ssh on port $port
qemu-kvm -m $MEMORY -vga qxl -smp $CPU_CORES -drive file=image.qcow2,format=qcow2 \
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
