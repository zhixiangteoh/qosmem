#!/bin/bash

cd /build_dir/qosmem/
cp grub /etc/default/grub
update-grub2
reboot
