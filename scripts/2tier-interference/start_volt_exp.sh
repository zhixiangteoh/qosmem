#!/bin/bash

pushd /build_dir/qosmem/scripts/2tier-interference
./lower_uncore_freq.sh
popd

EXPNAME=${1:-"exp"}
NUM_CORES=${2:-9}

# add `NUM_CORES` odd-numbered cores
cores=()
for i in $(seq 1 2 $((NUM_CORES * 2 - 1))); do
    if ((i % 2 != 0)); then
        cores+=($i)
    fi
done

# make into comma-separated string
cores_str=$(IFS=, ; echo "${cores[*]}")

echo "Running VoltDB experiment with $NUM_CORES cores: $cores_str; experiment name: $EXPNAME"

# compile Mercury/monitor/monitor
pushd /build_dir/Mercury/monitor
cmake .
make
popd

pushd /build_dir/voltdb
for i in {1..3}; do
    pushd /build_dir/Mercury/monitor
    monitor_memacc_output_file=/build_dir/qosmem/experiment-results/voltdb/mem-access-latency/monitor-$EXPNAME-$i.txt
    echo "Command: ./monitor -c $cores_str > $monitor_memacc_output_file &"
    ./monitor -c $cores_str > $monitor_memacc_output_file &
    monitor_pid=$!
    echo "Monitor PID: $monitor_pid"
    popd

    echo "Command: taskset -c $cores_str ./run_tpcc.sh xxx-$EXPNAME-$i.txt"
    taskset -c $cores_str ./run_tpcc.sh xxx-$EXPNAME-$i.txt

    echo "Killing monitor PID: $monitor_pid"
    kill -9 $monitor_pid
done
popd

# cleanup() {
#     echo "Killing monitor PID: $monitor_pid"
#     kill -9 $monitor_pid
# }

# trap cleanup EXIT

# popd
