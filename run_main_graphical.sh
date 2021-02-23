source config.sh

my_img="${1:-image.qcow2}"  # default to image.qcow2
qemu-kvm -m $MEMORY -vga qxl -smp $CPU_CORES -drive file=$my_img,format=qcow2 \
-device e1000,netdev=net0 \
-netdev user,id=net0
