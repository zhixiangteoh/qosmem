#!/bin/bash

MAX_WSS_IN_MB=${1:-20000} # 20 GB

LOCAL_DRAM_ARR_IN_MB=()
for ((i = 1; i <= 10; i++)); do
    LOCAL_DRAM_ARR_IN_MB+=($((MAX_WSS_IN_MB * i / 10))) # e.g., if MAX_WSS is 20GB, then LOCAL_DRAM_ARR is (0, 2, 4, ..., 20) (GB)
done
# LOCAL_DRAM_ARR_IN_MB=(1000 2000 3000 4000) # array of DRAM in 10% increments of MAX_WSS_IN_MB
LOCAL_DRAM_ARR_IN_GB=()
for i in "${!LOCAL_DRAM_ARR_IN_MB[@]}"; do
    LOCAL_DRAM_ARR_IN_GB[$i]=$((LOCAL_DRAM_ARR_IN_MB[$i] / 1000))
done
echo "LOCAL DRAM ALLOCATIONS (in GB): ${LOCAL_DRAM_ARR_IN_GB[@]}"

# compute configuration to grub file
# Now, with this you can now measure how an application performs when its allocated memory does not fully sit in local DRAM. To do this, you need to (1) measure the working set memory of the running application using the tool found here: https://github.com/brendangregg/wss, and (2) adjust the amount of available memory on local DRAM. To perform (2), you need to modify the cmd in the grub file. In particular, you need to adjust the following line found in grub:

# GRUB_CMDLINE_LINUX="isolcpus=0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62 memmap=110G!82G memmap=182G!202G"

# To decrease the local DRAM size, we need to change the second memmap cmd. To see how memmap cmd works. take a look at the first one , i.e., “ memmap=110G!82G”. This cmd says starting from memory address at 82GB, reserve the next 110 GB memory (equivalent to not being available to be used). So effectively we blocked 82~192GB memory on socket, left with 82GB usable memory. The beginning 2GB is always reserved for kernel, so that’s 82-2=80GB memory on socket 0. Note that on c6420, each socket has 192 GB memory. Thus socket 1 memory starts from 192GB to 384GB. The second memmap cmd thus gives you 8GB available memory on socket 1. Please do the math yourself to see whether you get it, and help me double check if my calculation is correct. More details of how memmap works can be found here: https://docs.pmem.io/persistent-memory/getting-started-guide/creating-development-environments/linux-environments/linux-memmap#how-to-choose-the-correct-memmap-option-for-your-system.

# each socket has 192 GB memory
REMOTE_DRAM_START_ADDR=0  # socket 0
LOCAL_DRAM_START_ADDR=192 # socket 1
KERNEL_DRAM=2             # beginning 2 GB reserved for kernel
for i in "${!LOCAL_DRAM_ARR_IN_MB[@]}"; do
    local_dram_in_mb=${LOCAL_DRAM_ARR_IN_MB[$i]}
    local_dram_in_gb=${LOCAL_DRAM_ARR_IN_GB[$i]}
    local_reserve_start_addr=$((LOCAL_DRAM_START_ADDR + local_dram_in_gb + KERNEL_DRAM))
    local_reserve_in_gb=$((192 - local_dram_in_gb - KERNEL_DRAM))
    # keep remote (socket 0) DRAM at 80GB (i.e., memmap=110G!82G)
    new_GRUB_CMDLINE_LINUX="GRUB_CMDLINE_LINUX=\"isolcpus=0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62 memmap=110G!82G memmap=${local_reserve_in_gb}G!${local_reserve_start_addr}G\""

    percentage=$(((i + 1) * 10))
    echo "$((local_dram_in_gb))GB ($percentage% of $((MAX_WSS_IN_MB / 1000))GB):" $new_GRUB_CMDLINE_LINUX
done
