# Motivation Experiments - Memory B/W Load on App Performance

## 2-tier memory system - performance of VoltDB against local memory bandwidth load

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

Memory setup: 192GB (default) local DRAM, 192GB (default) remote DRAM

### No external memory bandwidth load (i.e., 0 local CPU cores running `test_page_frequency`)

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

### 1 local CPU core running `test_page_frequency`

#### Run 1
```

```

#### Run 2
```

```

#### Run 3
```

```

### 2 local CPU cores running `test_page_frequency`

#### Run 1
```

```

#### Run 2
```

```

#### Run 3
```

```

### 4 local CPU cores running `test_page_frequency`

#### Run 1
```

```

#### Run 2
```

```

#### Run 3
```

```

### 8 local CPU cores running `test_page_frequency`

#### Run 1
```

```

#### Run 2
```

```

#### Run 3
```

```

### 12 local CPU cores running `test_page_frequency`

#### Run 1
```

```

#### Run 2
```

```

#### Run 3
```

```

### 16 local CPU cores running `test_page_frequency`

#### Run 1
```

```

#### Run 2
```

```

#### Run 3
```

```

### 20 local CPU cores running `test_page_frequency`

#### Run 1
```

```

#### Run 2
```

```

#### Run 3
```

```
