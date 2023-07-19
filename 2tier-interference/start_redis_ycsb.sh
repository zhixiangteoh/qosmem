#!/bin/bash

# First make remote memory accesses slower
pushd /build_dir/scripts
./lower_uncore_freq.sh
popd

# Run YCSB on Redis
pushd /build_dir/YCSB
# ./bin/ycsb load redis -s -P workloads/workload_zipfian -p "redis.host=127.0.0.1" -p "redis.port=6379"
./bin/ycsb run redis -s -P workloads/workload_zipfian -p "redis.host=127.0.0.1" -p "redis.port=6379" -p "status.interval=1"

# DON'T clear redis store since workload_zipfian insert % is 0
# redis-cli flushall

popd
