source config.sh

qemu-kvm -m $MEMORY -vga qxl -smp $CPU_CORES -drive file=image.qcow2,format=qcow2 \
-device e1000,netdev=net0 \
-netdev user,id=net0
