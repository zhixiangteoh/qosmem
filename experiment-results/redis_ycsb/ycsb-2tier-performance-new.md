# Motivation Experiments - 2-Tier Memory System

## 2-tier memory system - performance of YCSB on Redis against available local DRAM

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

### Max WSS (RSS): ~50GB

### 192GB (default) local DRAM, 192GB (default) remote DRAM (WSS ~50GB)

#### Run 1
```
[OVERALL], RunTime(ms), 734597
[OVERALL], Throughput(ops/sec), 1361.2906124038077
[TOTAL_GCS_PS_Scavenge], Count, 2984
[TOTAL_GC_TIME_PS_Scavenge], Time(ms), 5231
[TOTAL_GC_TIME_%_PS_Scavenge], Time(%), 0.7120911193484318
[TOTAL_GCS_PS_MarkSweep], Count, 0
[TOTAL_GC_TIME_PS_MarkSweep], Time(ms), 0
[TOTAL_GC_TIME_%_PS_MarkSweep], Time(%), 0.0
[TOTAL_GCs], Count, 2984
[TOTAL_GC_TIME], Time(ms), 5231
[TOTAL_GC_TIME_%], Time(%), 0.7120911193484318
[CLEANUP], Operations, 1
[CLEANUP], AverageLatency(us), 1265.0
[CLEANUP], MinLatency(us), 1265
[CLEANUP], MaxLatency(us), 1265
[CLEANUP], 95thPercentileLatency(us), 1265
[CLEANUP], 99thPercentileLatency(us), 1265
[INSERT], Operations, 1000000
[INSERT], AverageLatency(us), 732.220469
[INSERT], MinLatency(us), 261
[INSERT], MaxLatency(us), 334335
[INSERT], 95thPercentileLatency(us), 759
[INSERT], 99thPercentileLatency(us), 819
[INSERT], Return=OK, 1000000
```

### 50GB local DRAM, 80GB remote DRAM

#### Run 1
```

```

### 40GB local DRAM, 80GB remote DRAM

#### Run 1
```
```

### 30GB local DRAM, 80GB remote DRAM

#### Run 1
```
```

### 25GB local DRAM, 80GB remote DRAM

#### Run 1
```
```

### 20GB local DRAM, 80GB remote DRAM

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

### 5GB local DRAM, 80GB remote DRAM

#### Run 1
```
```

### 2GB local DRAM, 80GB remote DRAM

#### Run 1
```
```

### 1GB local DRAM, 80GB remote DRAM

#### Run 1
```
```
