#!/bin/bash

# Usage: ./parse-stats-saturate-bandwidth.sh <num_requests>
NREQUESTS=${1:-10000}

cd ~/redis/memtier_benchmark
for stats_file in mem_vs_nprocesses-1-0-d*-n$NREQUESTS.out;
do
    # Get data_size (number after d) from filename
    data_size=$(echo $stats_file | sed -e 's/.*-d\([0-9]*\)-.*/\1/g')
    > stats-$data_size.tmp # Clear stats file

    # # Ops/sec Hits/sec Misses/sec Avg. Latency p50 Latency p95 Latency p99 Latency p99.9 Latency KB/sec
    sed -e '/^Sets.*/,$!d' -e '/^Waits.*/d' -e 's/\(Sets\|Gets\|Waits\|Totals\) *\([^ ]*\) *[^ ]* *[^ ]* *\([^ ]*\) *[^ ]* *\([^ ]*\) *\([^ ]*\) *\([^ ]*\)/\1\t\2\t\3\t\4\t\5\t\6/' $stats_file >> stats-$data_size.tmp

    # Get averages of all stats
    # Data in the form of:
    #   Sets {OPS/SEC} {AVG_LATENCY} {P90_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Gets {OPS/SEC} {AVG_LATENCY} {P90_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Totals {OPS/SEC} {AVG_LATENCY} {P90_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Sets {OPS/SEC} {AVG_LATENCY} {P90_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Gets {OPS/SEC} {AVG_LATENCY} {P90_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Totals {OPS/SEC} {AVG_LATENCY} {P90_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   ...
    #   ...
    sets_avg_ops_per_sec=$(awk '/^Sets/ {sum += $2; n++} END {print sum / n}' stats-$data_size.tmp)
    sets_avg_latency=$(awk '/^Sets/ {sum += $3; n++} END {print sum / n}' stats-$data_size.tmp)
    sets_p90_latency=$(awk '/^Sets/ {sum += $4; n++} END {print sum / n}' stats-$data_size.tmp)
    sets_p99_9_latency=$(awk '/^Sets/ {sum += $5; n++} END {print sum / n}' stats-$data_size.tmp)
    sets_kb_per_sec=$(awk '/^Sets/ {sum += $6; n++} END {print sum / n}' stats-$data_size.tmp)

    gets_avg_ops_per_sec=$(awk '/^Gets/ {sum += $2; n++} END {print sum / n}' stats-$data_size.tmp)
    gets_avg_latency=$(awk '/^Gets/ {sum += $3; n++} END {print sum / n}' stats-$data_size.tmp)
    gets_p90_latency=$(awk '/^Gets/ {sum += $4; n++} END {print sum / n}' stats-$data_size.tmp)
    gets_p99_9_latency=$(awk '/^Gets/ {sum += $5; n++} END {print sum / n}' stats-$data_size.tmp)
    gets_kb_per_sec=$(awk '/^Gets/ {sum += $6; n++} END {print sum / n}' stats-$data_size.tmp)

    totals_avg_ops_per_sec=$(awk '/^Totals/ {sum += $2; n++} END {print sum / n}' stats-$data_size.tmp)
    totals_avg_latency=$(awk '/^Totals/ {sum += $3; n++} END {print sum / n}' stats-$data_size.tmp)
    totals_p90_latency=$(awk '/^Totals/ {sum += $4; n++} END {print sum / n}' stats-$data_size.tmp)
    totals_p99_9_latency=$(awk '/^Totals/ {sum += $5; n++} END {print sum / n}' stats-$data_size.tmp)
    totals_kb_per_sec=$(awk '/^Totals/ {sum += $6; n++} END {print sum / n}' stats-$data_size.tmp)

    echo -e "Sets\t$sets_avg_ops_per_sec\t$sets_avg_latency\t$sets_p90_latency\t$sets_p99_9_latency\t$sets_kb_per_sec" > avg-stats-$data_size.out
    echo -e "Gets\t$gets_avg_ops_per_sec\t$gets_avg_latency\t$gets_p90_latency\t$gets_p99_9_latency\t$gets_kb_per_sec" >> avg-stats-$data_size.out
    echo -e "Totals\t$totals_avg_ops_per_sec\t$totals_avg_latency\t$totals_p90_latency\t$totals_p99_9_latency\t$totals_kb_per_sec" >> avg-stats-$data_size.out
done
