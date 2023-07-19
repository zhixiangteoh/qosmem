#!/bin/bash

# Usage: ./print-stats.sh [<working_dir> <prefix>]
WORKING_DIR=${1:-$HOME/redis/memtier_benchmark}
PREFIX=${2:-mem_interference_many}

cd $WORKING_DIR

# $PREFIX-stats*.tmp files must exist
if ls $PREFIX-stats*.stats 1>/dev/null 2>&1; then
    true
else
    echo "avg-stats*.stats don't exist; run parse-stats.sh first"
fi

grep -E 'Sets.*' $PREFIX-stats*.stats | sed -e 's/[^0-9]*\([0-9]\+\)\.stats:Sets\t\(.*\)/\1\t\2/g' | sort -n -s -k1,1 >$PREFIX-sets-stats.out
grep -E 'Gets.*' $PREFIX-stats*.stats | sed -e 's/[^0-9]*\([0-9]\+\)\.stats:Gets\t\(.*\)/\1\t\2/g' | sort -n -s -k1,1 >$PREFIX-gets-stats.out
grep -E 'Totals.*' $PREFIX-stats*.stats | sed -e 's/[^0-9]*\([0-9]\+\)\.stats:Totals\t\(.*\)/\1\t\2/g' | sort -n -s -k1,1 >$PREFIX-totals-stats.out

cd -
