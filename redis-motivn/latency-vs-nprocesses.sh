#!/bin/bash

# Assume Redis instance running in the background, without memory limit
PID_REDIS_SERVER=$(pgrep -f ".*zhteoh.*redis-server.*")
if [ -z "$PID_REDIS_SERVER" ]
then
    echo "Redis server not running; run `~/redis/src/redis-server ~/redis/redis.conf` first."
    exit 1
fi

# Usage: ./latency-vs-nprocesses.sh <min_nprocesses> <max_nprocesses> <nthreads> <nrequests>
MIN_NPROCESSES=${1:-1}
MAX_NPROCESSES=${2:-15}

# default to 20 if not specified
NTHREADS=${3:-20}
NREQUESTS=${4:-100000}
DATA_SIZE=${5:-1000}

redis-cli flushall

cd ~/redis/memtier_benchmark
for (( nprocesses=$MIN_NPROCESSES; nprocesses<=$MAX_NPROCESSES; nprocesses++ ))
do
    # Run nprocesses number of memtier_benchmark applications in the background, and wait for them to finish
    ~/wss/wss.pl -s 0 $PID_REDIS_SERVER 1 > wss-$nprocesses\_processes.out & # Start measuring working set size (WSS)
    pid_wss=$!
    pids=() # array of memtier_benchmark application pids
    for (( i=0; i<$nprocesses; i++ ));
    do
        taskset -c $((i*2)) ./memtier_benchmark -t $NTHREADS -n $NREQUESTS --ratio 1:1 -c 20 -x 1 --key-pattern R:R --hide-histogram --distinct-client-seed -d $DATA_SIZE --pipeline=1 --hdr-file-prefix=mem_vs_nprocesses-$nprocesses-$i-d$DATA_SIZE-n$NREQUESTS |& tee mem_vs_nprocesses-$nprocesses-$i-d$DATA_SIZE-n$NREQUESTS.out &
        pids+=($!)
    done
    # wait for all memtier_benchmark applications to finish
    for pid in ${pids[@]}; 
    do
        wait $pid
    done
    kill $pid_wss # Stop measuring WSS after processes complete
    redis-cli flushall
    # clear mem usage
    sudo sh -c "sync; echo 1 > /proc/sys/vm/drop_caches"
    sudo sh -c "sync; echo 2 > /proc/sys/vm/drop_caches"
    sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"
    sleep 1m # wait for mem to be cleared
done
cd -
