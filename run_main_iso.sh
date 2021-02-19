source config.sh
if [ "$#" -ne 1 ]; then
    echo Requires the ISO as an argument
    exit
fi

if ! (test -f image.qcow2); then
    ./image_wizard.sh
fi

qemu-kvm -m $MEMORY -vga qxl -smp $CPU_CORES -drive file=image.qcow2,format=qcow2 \
-device e1000,netdev=net0 \
-netdev user,id=net0 \
-cdrom $1
