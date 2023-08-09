#!/bin/bash

X=${1:-1}

pushd /build_dir/hopscotch/run/microbenchmark
cmake .
make

numactl --cpunodebind=1 ./test_page_freq 131072 128 64 bw 2048000 1.4 130000 1 0 $X 0

popd
