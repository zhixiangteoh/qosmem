#!/bin/bash

NTHREADS=${1:-20}
NREQUESTS=${2:-2000}

cd ~/qosmem-scripts
# Try to saturate bandwidth by increasing data size per operation
data_sizes=(1000 5000 10000 40000 50000 60000 80000 100000 120000 200000 400000 500000 800000 1000000)
DATA_SIZES=${3:-${data_sizes[@]}}
for data_size in $DATA_SIZES;
do
    ./latency-vs-nprocesses.sh 1 1 $NTHREADS $NREQUESTS $data_size
done
cd -
