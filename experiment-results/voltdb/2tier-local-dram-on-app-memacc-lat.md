# Motivation Experiments - Available Local DRAM on App/Mem Access-Level Latency 

## 2-tier memory system - performance of VoltDB against available local DRAM

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

CPU usage: <900% (i.e., <9 cores)

### Diagnostic experiments



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

```

#### Run 2
```

```

#### Run 3
```

```
