#!/bin/bash

# Usage: ./parse-wss.sh <min_nprocesses> <max_nprocesses>
MIN_NPROCESSES=${1:-1}
MAX_NPROCESSES=${2:-15}

# Output of wss-$nprocesses_processes.out:
# Watching PID 654328 page references for every 1 seconds...
# Est(s)     RSS(MB)    PSS(MB)    Ref(MB)
# 1.003        58.36      55.75      55.80
# 1.003        99.98      97.38      60.24
# 1.004       144.01     141.41      66.09
# 1.006       188.41     185.81      68.87

cd ~/redis/memtier_benchmark
for (( nprocesses=$MIN_NPROCESSES; nprocesses<=$MAX_NPROCESSES; nprocesses++ ))
do
    sed -i '1 ! s/\([^ ]*\) *\([^ ]*\) *\([^ ]*\) *\([^ ]*\)/\1\t\2\t\3\t\4/g' wss-$nprocesses\_processes.out
done
cd -
