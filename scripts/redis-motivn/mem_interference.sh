#!/bin/bash

trap "cleanup" SIGINT SIGTERM EXIT

cleanup() {
    echo "Caught SIGINT signal; cleaning up..."
    kill $wss_pid
    for pid in ${app_pids[@]}; do
        kill $pid
    done

    redis-cli flushall
    # clear mem usage
    sudo sh -c "sync; echo 1 > /proc/sys/vm/drop_caches"
    sudo sh -c "sync; echo 2 > /proc/sys/vm/drop_caches"
    sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"

    exit 1
}

# Assume Redis instance running in the background, without memory limit
PID_REDIS_SERVER=$(pgrep -f ".*zhteoh.*redis-server.*")
if [ -z "$PID_REDIS_SERVER" ]; then
    echo "Redis server not running; run $(~/redis/src/redis-server ~/redis/redis.conf) first."
    exit 1
fi

# Usage: ./latency-vs-nprocesses.sh [<min_nprocesses> <max_nprocesses> <repetitions> <nthreads> <nrequests> <large_data_size> <small_data_size>]
MIN_NPROCESSES=${1:-1}
MAX_NPROCESSES=${2:-15}

REPS=${3:-5}

NTHREADS=${4:-1}
NREQUESTS_LARGE=${5:-10000}   # effectively 100K ops
NREQUESTS_SMALL=${6:-100000}  # effectively 1M ops
LARGE_DATA_SIZE=${7:-5000000} # default: 5 MB
SMALL_DATA_SIZE=${8:-1000}    # default: 1 KB

redis-cli flushall

cd ~/redis/memtier_benchmark
for ((rep = 1; rep <= $REPS; rep++)); do
    for ((nprocesses = $MIN_NPROCESSES; nprocesses <= $MAX_NPROCESSES; nprocesses++)); do
        # Run nprocesses number of memtier_benchmark applications in the background, and wait for them to finish
        ~/wss/wss.pl -s 0 $PID_REDIS_SERVER 1 >wss-$nprocesses\_processes.out & # Start measuring working set size (WSS)
        wss_pid=$!
        app_pids=() # array of memtier_benchmark application pids
        for ((i = 0; i < $nprocesses; i++)); do
            # Run several applications executing large data ops
            many_log_filename="mem_interference_many-$nprocesses-$i-d$LARGE_DATA_SIZE-n$NREQUESTS_LARGE-rep$rep"
            taskset -c $((i * 2)) memtier_benchmark -t $NTHREADS -n $NREQUESTS_LARGE --ratio 9999:1 -c 20 -x 1 --key-pattern R:R --hide-histogram --distinct-client-seed -d $LARGE_DATA_SIZE --pipeline=1 |& tee $many_log_filename.out &
            app_pids+=($!)
        done

        sleep 10s # wait for memtier_benchmark applications to start

        # Run single application executing small data op
        single_log_filename="mem_interference_single-$nprocesses-d$SMALL_DATA_SIZE-n$NREQUESTS_SMALL-rep$rep"
        taskset -c 62 memtier_benchmark -t $NTHREADS -n $NREQUESTS_SMALL --ratio 1:1 -c 20 -x 1 --key-pattern R:R --hide-histogram --distinct-client-seed -d $SMALL_DATA_SIZE --pipeline=1 |& tee $single_log_filename.out &
        app_pids+=($!)
        # wait for all memtier_benchmark applications to finish
        for pid in ${app_pids[@]}; do
            wait $pid
            app_pids=(${app_pids[@]/$pid/})
        done
        kill $wss_pid # Stop measuring WSS after processes complete
        redis-cli flushall
        # clear mem usage
        sudo sh -c "sync; echo 1 > /proc/sys/vm/drop_caches"
        sudo sh -c "sync; echo 2 > /proc/sys/vm/drop_caches"
        sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"
        sleep 20s # wait for mem to be cleared
    done
done
cd -
