#!/bin/bash

# for *.dat in this directory,
# move them to a subdirectory named after the file
DATA_DIR=${1:-/build_dir/spark-tpc-ds-performance-test/src/data}

pushd $DATA_DIR

for f in *.dat; do
    mkdir -p "${f%.*}"
    mv "$f" "${f%.*}"
done

popd
