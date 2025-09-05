#!/bin/sh
qemu-system-x86_64 -boot order=d -drive file=/home/lush/win10.img -accel kvm -m 8G -k en-us -vga std -usb -device usb-tablet
