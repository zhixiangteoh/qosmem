#!/bin/bash

cd /build_dir
cp grub /etc/default/grub
update-grub2
reboot
