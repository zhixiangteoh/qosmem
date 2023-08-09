#!/bin/bash

# pushd /build_dir/scripts
# ./lower_uncore_freq.sh

EXPNAME=${1:-"exp"}
pushd /build_dir/voltdb
for i in {1..3}; do
    numactl --cpunodebind=1 ./run_tpcc.sh xxx-$EXPNAME-$i.txt
done
popd

# popd
