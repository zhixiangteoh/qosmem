#!/bin/bash

# Usage: ./parse-stats.sh [<working_dir> <min_nprocesses> <max_nprocesses> <repetitions> <prefix> <suffix>]
WORKING_DIR=${1:-$HOME/redis/memtier_benchmark}
MIN_NPROCESSES=${2:-1}
MAX_NPROCESSES=${3:-15}

REPS=${4:-5}

PREFIX=${5:-mem_interference_many}
SUFFIX=${6:-d5000000-n1000}

# `tally_for_repetition $STATS_FILE $nprocesses $rep`
tally_for_repetition() {
    STATS_FILE=$1
    nprocesses=$2
    rep=$3

    # Ops/sec Hits/sec Misses/sec Avg. Latency p50 Latency p99 Latency p99.9 Latency KB/sec
    sed -e '/^Sets.*/,$!d' -e '/^Waits.*/d' -e 's/\(Sets\|Gets\|Waits\|Totals\) *\([^ ]*\) *[^ ]* *[^ ]* *\([^ ]*\) *[^ ]* *\([^ ]*\) *\([^ ]*\) *\([^ ]*\)/\1\t\2\t\3\t\4\t\5\t\6/' $STATS_FILE >>/tmp/stats-$nprocesses-rep$rep.tmp

    # Get averages of all stats
    # Data in the form of:
    #   Sets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Gets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Totals {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Sets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Gets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Totals {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   ...
    #   ...
    sets_avg_ops_per_sec=$(awk '/^Sets/ {sum += $2; n++} END {print sum}' /tmp/stats-$nprocesses-rep$rep.tmp)
    sets_avg_latency=$(awk '/^Sets/ {sum += $3; n++} END {print sum / n}' /tmp/stats-$nprocesses-rep$rep.tmp)
    sets_p99_latency=$(awk '/^Sets/ {sum += $4; n++} END {print sum / n}' /tmp/stats-$nprocesses-rep$rep.tmp)
    sets_p99_9_latency=$(awk '/^Sets/ {sum += $5; n++} END {print sum / n}' /tmp/stats-$nprocesses-rep$rep.tmp)
    sets_kb_per_sec=$(awk '/^Sets/ {sum += $6; n++} END {print sum}' /tmp/stats-$nprocesses-rep$rep.tmp)

    gets_avg_ops_per_sec=$(awk '/^Gets/ {sum += $2; n++} END {print sum}' /tmp/stats-$nprocesses-rep$rep.tmp)
    gets_avg_latency=$(awk '/^Gets/ {sum += $3; n++} END {print sum / n}' /tmp/stats-$nprocesses-rep$rep.tmp)
    gets_p99_latency=$(awk '/^Gets/ {sum += $4; n++} END {print sum / n}' /tmp/stats-$nprocesses-rep$rep.tmp)
    gets_p99_9_latency=$(awk '/^Gets/ {sum += $5; n++} END {print sum / n}' /tmp/stats-$nprocesses-rep$rep.tmp)
    gets_kb_per_sec=$(awk '/^Gets/ {sum += $6; n++} END {print sum}' /tmp/stats-$nprocesses-rep$rep.tmp)

    totals_avg_ops_per_sec=$(awk '/^Totals/ {sum += $2; n++} END {print sum}' /tmp/stats-$nprocesses-rep$rep.tmp)
    totals_avg_latency=$(awk '/^Totals/ {sum += $3; n++} END {print sum / n}' /tmp/stats-$nprocesses-rep$rep.tmp)
    totals_p99_latency=$(awk '/^Totals/ {sum += $4; n++} END {print sum / n}' /tmp/stats-$nprocesses-rep$rep.tmp)
    totals_p99_9_latency=$(awk '/^Totals/ {sum += $5; n++} END {print sum / n}' /tmp/stats-$nprocesses-rep$rep.tmp)
    totals_kb_per_sec=$(awk '/^Totals/ {sum += $6; n++} END {print sum}' /tmp/stats-$nprocesses-rep$rep.tmp)

    echo -e "Sets\t$sets_avg_ops_per_sec\t$sets_avg_latency\t$sets_p99_latency\t$sets_p99_9_latency\t$sets_kb_per_sec" >/tmp/$PREFIX-rep$rep-stats-$nprocesses.tmp
    echo -e "Gets\t$gets_avg_ops_per_sec\t$gets_avg_latency\t$gets_p99_latency\t$gets_p99_9_latency\t$gets_kb_per_sec" >>/tmp/$PREFIX-rep$rep-stats-$nprocesses.tmp
    echo -e "Totals\t$totals_avg_ops_per_sec\t$totals_avg_latency\t$totals_p99_latency\t$totals_p99_9_latency\t$totals_kb_per_sec" >>/tmp/$PREFIX-rep$rep-stats-$nprocesses.tmp
}

cd $WORKING_DIR
for ((nprocesses = $MIN_NPROCESSES; nprocesses <= $MAX_NPROCESSES; nprocesses++)); do
    for ((rep = 1; rep <= $REPS; rep++)); do
        truncate -s 0 /tmp/stats-$nprocesses-rep$rep.tmp # Clear stats file

        if [[ $PREFIX == *"single"* ]]; then
            STATS_FILE=$PREFIX-$nprocesses-$SUFFIX-rep$rep.out
            tally_for_repetition $STATS_FILE $nprocesses $rep
        else
            # Tally for each repetition
            for ((i = 0; i < $nprocesses; i++)); do
                STATS_FILE=$PREFIX-$nprocesses-$i-$SUFFIX-rep$rep.out
                tally_for_repetition $STATS_FILE $nprocesses $rep
            done
        fi
    done

    # Collate across all repetitions
    # Data in the form of:
    #  $PREFIX-rep1-stats-$nprocesses.tmp:
    #   Sets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Gets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Totals {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #  $PREFIX-rep2-stats-$nprocesses.tmp:
    #   Sets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Gets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Totals {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #  ...
    #  $PREFIX-rep5-stats-$nprocesses.tmp:
    #   Sets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Gets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Totals {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    # Result:
    #  $PREFIX-stats-$nprocesses.tmp:
    #   Sets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Sets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   ... (5 lines)
    #   Gets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Gets {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   ... (5 lines)
    #   Totals {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   Totals {OPS/SEC} {AVG_LATENCY} {P99_LATENCY} {P99.9_LATENCY} {KB/SEC}
    #   ... (5 lines)
    COLLATED_STATS_FILE=$PREFIX-stats-$nprocesses.stats
    truncate -s 0 $COLLATED_STATS_FILE
    for stat in Sets Gets Totals; do
        for ((rep = 1; rep <= $REPS; rep++)); do
            cat /tmp/$PREFIX-rep$rep-stats-$nprocesses.tmp | grep $stat >>$COLLATED_STATS_FILE
        done
    done
done

cd -
