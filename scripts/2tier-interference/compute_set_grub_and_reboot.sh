#!/bin/bash

LOCAL_DRAM_IN_GB=${1:-192}

# each socket has 192 GB memory
REMOTE_DRAM_START_ADDR=0  # socket 0
LOCAL_DRAM_START_ADDR=192 # socket 1
KERNEL_DRAM=2             # beginning 2 GB reserved for kernel

local_reserve_start_addr=$((LOCAL_DRAM_START_ADDR + LOCAL_DRAM_IN_GB + KERNEL_DRAM))
local_reserve_in_gb=$((192 - LOCAL_DRAM_IN_GB - KERNEL_DRAM))
# keep remote (socket 0) DRAM at 80GB (i.e., memmap=110G!82G)
new_GRUB_CMDLINE_LINUX="GRUB_CMDLINE_LINUX=\"isolcpus=0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62 memmap=110G!82G memmap=${local_reserve_in_gb}G!${local_reserve_start_addr}G\""

# replace "GRUB_CMDLINE_LINUX..." line in /etc/default/grub
sudo sed -i "s/^GRUB_CMDLINE_LINUX.*/${new_GRUB_CMDLINE_LINUX}/" /etc/default/grub
update-grub2
reboot
