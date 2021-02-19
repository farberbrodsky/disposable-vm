echo Image Wizard

read -r -p "image size (default 32G, not allocated): " image_size
if [ -z "$image_size" ]; then
    image_size=32G
fi

qemu-img create -f qcow2 image.qcow2 $image_size
