#!/bin/bash

pushd /build_dir/scripts
./lower_uncore_freq.sh

pushd /build_dir/voltdb
for i in {1..3}; do
    ./run_tpcc.sh $i
done
popd

popd
