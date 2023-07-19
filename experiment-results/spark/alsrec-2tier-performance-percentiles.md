# Motivation Experiments - 2-Tier Memory System

## 2-tier memory system - performance of Spark ALS Recommender against available local DRAM

```sh
function client() {
    jars-ifneeded
    java -classpath $APPNAME-client.jar:$APPNAME-procs.jar:$APPCLASSPATH com.MyTPCC \
        --servers=localhost \
        --transactions=580000 \
	--ratelimit=200000 \
        --warehouses=256 \
        --scalefactor=5
}
```

### Max WSS (RSS): ~21.6GB

### 192GB (default) local DRAM, 192GB (default) remote DRAM

#### Run 1
```
```

#### Run 2
```
```

#### Run 3
```
```

---

### 20GB local DRAM, 80GB remote DRAM

#### Run 1
```
```

#### Run 2
```
```

#### Run 3
```
```

### 18GB local DRAM, 80GB remote DRAM

#### Run 1
```
```

#### Run 2
```
```

#### Run 3
```
```

### 16GB local DRAM, 80GB remote DRAM

#### Run 1
```
```

#### Run 2
```
```

#### Run 3
```
```

### 14GB local DRAM, 80GB remote DRAM

#### Run 1
```

```

### 10GB local DRAM, 80GB remote DRAM

#### Run 1
```
```

#### Run 2
```
```

#### Run 3
```
```

### 6GB local DRAM, 80GB remote DRAM

#### Run 1
```
```

#### Run 2
```
```

#### Run 3
```
```

### 2GB local DRAM, 80GB remote DRAM

#### Run 1
```
======================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 217552 ms
Total transactions: 5800000
Transactions per second: 26660.29
            Stock Level:     232560 total      1068.99 txn/s     64139.15 txn/m
               Delivery:     231959 total      1066.22 txn/s     63973.39 txn/m
           Order Status:     231856 total      1065.75 txn/s     63944.99 txn/m
                Payment:    2493985 total     11463.86 txn/s    687831.44 txn/m
              New Order:    2609640 total     11995.48 txn/s    719728.63 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 77.94 ms
 - Median Latency = 56 ms
 - 75-th Percentile Latency = 75 ms
 - 90-th Percentile Latency = 132 ms
 - 95-th Percentile Latency = 153 ms
 - 99-th Percentile Latency = 225 ms
=================================================================================
```

#### Run 2
```
```

#### Run 3
```
```

### 1GB local DRAM, 80GB remote DRAM

#### Run 1
```
======================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 220231 ms
Total transactions: 5800000
Transactions per second: 26335.98
            Stock Level:     232560 total      1055.98 txn/s     63358.93 txn/m
               Delivery:     231959 total      1053.25 txn/s     63195.19 txn/m
           Order Status:     231856 total      1052.79 txn/s     63167.13 txn/m
                Payment:    2493985 total     11324.40 txn/s    679464.31 txn/m
              New Order:    2609640 total     11849.56 txn/s    710973.50 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 78.92 ms
 - Median Latency = 57 ms
 - 75-th Percentile Latency = 74 ms
 - 90-th Percentile Latency = 140 ms
 - 95-th Percentile Latency = 159 ms
 - 99-th Percentile Latency = 226 ms
=================================================================================
```

#### Run 2
```
```

#### Run 3
```
```
