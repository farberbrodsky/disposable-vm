source config.sh
if [ "$#" -eq 0 ]; then
    echo Requires the ISO as an argument, optionally the image
    exit
fi

if ! (test -f image.qcow2); then
    ./image_wizard.sh
fi

my_img="${2:-image.qcow2}"  # default to image.qcow2
$QEMU_CMD -m $MEMORY -vga qxl -smp $CPU_CORES -drive file=$my_img,format=qcow2 \
-device e1000,netdev=net0 \
-netdev user,id=net0 \
-cdrom $1
