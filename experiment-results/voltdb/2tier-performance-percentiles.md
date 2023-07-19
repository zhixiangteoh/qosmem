# Motivation Experiments - 2-Tier Memory System

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

### Max WSS (RSS): ~16.2GB
### Max WSS (Ref):  ~3.4GB

### 192GB (default) local DRAM, 192GB (default) remote DRAM

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 179508 ms
Total transactions: 5800000
Transactions per second: 32310.54
            Stock Level:     232560 total      1295.54 txn/s     77732.47 txn/m
               Delivery:     231959 total      1292.19 txn/s     77531.59 txn/m
           Order Status:     231856 total      1291.62 txn/s     77497.16 txn/m
                Payment:    2493985 total     13893.45 txn/s    833606.88 txn/m
              New Order:    2609640 total     14537.74 txn/s    872264.19 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 64.01 ms
 - Median Latency = 48 ms
 - 75-th Percentile Latency = 64 ms
 - 90-th Percentile Latency = 113 ms
 - 95-th Percentile Latency = 129 ms
 - 99-th Percentile Latency = 158 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 181758 ms
Total transactions: 5800000
Transactions per second: 31910.56
            Stock Level:     232560 total      1279.50 txn/s     76770.21 txn/m
               Delivery:     231959 total      1276.20 txn/s     76571.82 txn/m
           Order Status:     231856 total      1275.63 txn/s     76537.81 txn/m
                Payment:    2493985 total     13721.46 txn/s    823287.63 txn/m
              New Order:    2609640 total     14357.77 txn/s    861466.38 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 64.80 ms
 - Median Latency = 48 ms
 - 75-th Percentile Latency = 64 ms
 - 90-th Percentile Latency = 113 ms
 - 95-th Percentile Latency = 130 ms
 - 99-th Percentile Latency = 159 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 181028 ms
Total transactions: 5800000
Transactions per second: 32039.24
            Stock Level:     232560 total      1284.66 txn/s     77079.79 txn/m
               Delivery:     231959 total      1281.34 txn/s     76880.59 txn/m
           Order Status:     231856 total      1280.77 txn/s     76846.45 txn/m
                Payment:    2493985 total     13776.79 txn/s    826607.50 txn/m
              New Order:    2609640 total     14415.67 txn/s    864940.25 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 64.51 ms
 - Median Latency = 48 ms
 - 75-th Percentile Latency = 64 ms
 - 90-th Percentile Latency = 113 ms
 - 95-th Percentile Latency = 130 ms
 - 99-th Percentile Latency = 159 ms
=================================================================================
```

---

### 20GB local DRAM, 80GB remote DRAM

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 193737 ms
Total transactions: 5800000
Transactions per second: 29937.49
            Stock Level:     232560 total      1200.39 txn/s     72023.41 txn/m
               Delivery:     231959 total      1197.29 txn/s     71837.28 txn/m
           Order Status:     231856 total      1196.76 txn/s     71805.38 txn/m
                Payment:    2493985 total     12873.04 txn/s    772382.69 txn/m
              New Order:    2609640 total     13470.01 txn/s    808200.81 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 69.08 ms
 - Median Latency = 49 ms
 - 75-th Percentile Latency = 64 ms
 - 90-th Percentile Latency = 120 ms
 - 95-th Percentile Latency = 137 ms
 - 99-th Percentile Latency = 189 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 191821 ms
Total transactions: 5800000
Transactions per second: 30236.52
            Stock Level:     232560 total      1212.38 txn/s     72742.82 txn/m
               Delivery:     231959 total      1209.25 txn/s     72554.83 txn/m
           Order Status:     231856 total      1208.71 txn/s     72522.61 txn/m
                Payment:    2493985 total     13001.63 txn/s    780097.63 txn/m
              New Order:    2609640 total     13604.56 txn/s    816273.50 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 68.45 ms
 - Median Latency = 49 ms
 - 75-th Percentile Latency = 67 ms
 - 90-th Percentile Latency = 113 ms
 - 95-th Percentile Latency = 132 ms
 - 99-th Percentile Latency = 186 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 192256 ms
Total transactions: 5800000
Transactions per second: 30168.11
            Stock Level:     232560 total      1209.64 txn/s     72578.23 txn/m
               Delivery:     231959 total      1206.51 txn/s     72390.66 txn/m
           Order Status:     231856 total      1205.98 txn/s     72358.52 txn/m
                Payment:    2493985 total     12972.21 txn/s    778332.56 txn/m
              New Order:    2609640 total     13573.78 txn/s    814426.63 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 68.60 ms
 - Median Latency = 49 ms
 - 75-th Percentile Latency = 65 ms
 - 90-th Percentile Latency = 117 ms
 - 95-th Percentile Latency = 135 ms
 - 99-th Percentile Latency = 189 ms
=================================================================================
```

### 18GB local DRAM, 80GB remote DRAM

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 192898 ms
Total transactions: 5800000
Transactions per second: 30067.71
            Stock Level:     232560 total      1205.61 txn/s     72336.68 txn/m
               Delivery:     231959 total      1202.50 txn/s     72149.74 txn/m
           Order Status:     231856 total      1201.96 txn/s     72117.70 txn/m
                Payment:    2493985 total     12929.04 txn/s    775742.13 txn/m
              New Order:    2609640 total     13528.60 txn/s    811716.06 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 68.78 ms
 - Median Latency = 49 ms
 - 75-th Percentile Latency = 65 ms
 - 90-th Percentile Latency = 120 ms
 - 95-th Percentile Latency = 137 ms
 - 99-th Percentile Latency = 190 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 192184 ms
Total transactions: 5800000
Transactions per second: 30179.41
            Stock Level:     232560 total      1210.09 txn/s     72605.41 txn/m
               Delivery:     231959 total      1206.96 txn/s     72417.78 txn/m
           Order Status:     231856 total      1206.43 txn/s     72385.63 txn/m
                Payment:    2493985 total     12977.07 txn/s    778624.13 txn/m
              New Order:    2609640 total     13578.86 txn/s    814731.69 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 68.58 ms
 - Median Latency = 50 ms
 - 75-th Percentile Latency = 64 ms
 - 90-th Percentile Latency = 115 ms
 - 95-th Percentile Latency = 133 ms
 - 99-th Percentile Latency = 196 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 192830 ms
Total transactions: 5800000
Transactions per second: 30078.31
            Stock Level:     232560 total      1206.04 txn/s     72362.19 txn/m
               Delivery:     231959 total      1202.92 txn/s     72175.18 txn/m
           Order Status:     231856 total      1202.39 txn/s     72143.13 txn/m
                Payment:    2493985 total     12933.59 txn/s    776015.69 txn/m
              New Order:    2609640 total     13533.37 txn/s    812002.25 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 68.76 ms
 - Median Latency = 49 ms
 - 75-th Percentile Latency = 65 ms
 - 90-th Percentile Latency = 118 ms
 - 95-th Percentile Latency = 135 ms
 - 99-th Percentile Latency = 188 ms
=================================================================================
```

### 16GB local DRAM, 80GB remote DRAM

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 199708 ms
Total transactions: 5800000
Transactions per second: 29042.40
            Stock Level:     232560 total      1164.50 txn/s     69870.02 txn/m
               Delivery:     231959 total      1161.49 txn/s     69689.45 txn/m
           Order Status:     231856 total      1160.98 txn/s     69658.51 txn/m
                Payment:    2493985 total     12488.16 txn/s    749289.50 txn/m
              New Order:    2609640 total     13067.28 txn/s    784036.75 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 71.30 ms
 - Median Latency = 51 ms
 - 75-th Percentile Latency = 68 ms
 - 90-th Percentile Latency = 117 ms
 - 95-th Percentile Latency = 135 ms
 - 99-th Percentile Latency = 216 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 200885 ms
Total transactions: 5800000
Transactions per second: 28872.24
            Stock Level:     232560 total      1157.68 txn/s     69460.64 txn/m
               Delivery:     231959 total      1154.69 txn/s     69281.13 txn/m
           Order Status:     231856 total      1154.17 txn/s     69250.37 txn/m
                Payment:    2493985 total     12414.99 txn/s    744899.38 txn/m
              New Order:    2609640 total     12990.72 txn/s    779443.00 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 71.77 ms
 - Median Latency = 51 ms
 - 75-th Percentile Latency = 66 ms
 - 90-th Percentile Latency = 131 ms
 - 95-th Percentile Latency = 148 ms
 - 99-th Percentile Latency = 197 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 200111 ms
Total transactions: 5800000
Transactions per second: 28983.91
            Stock Level:     232560 total      1162.16 txn/s     69729.30 txn/m
               Delivery:     231959 total      1159.15 txn/s     69549.10 txn/m
           Order Status:     231856 total      1158.64 txn/s     69518.22 txn/m
                Payment:    2493985 total     12463.01 txn/s    747780.50 txn/m
              New Order:    2609640 total     13040.96 txn/s    782457.75 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 71.47 ms
 - Median Latency = 51 ms
 - 75-th Percentile Latency = 68 ms
 - 90-th Percentile Latency = 120 ms
 - 95-th Percentile Latency = 138 ms
 - 99-th Percentile Latency = 193 ms
=================================================================================
```

### 14GB local DRAM, 80GB remote DRAM

#### Run 1
```

```

### 10GB local DRAM, 80GB remote DRAM

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 207452 ms
Total transactions: 5800000
Transactions per second: 27958.28
            Stock Level:     232560 total      1121.03 txn/s     67261.83 txn/m
               Delivery:     231959 total      1118.13 txn/s     67088.00 txn/m
           Order Status:     231856 total      1117.64 txn/s     67058.21 txn/m
                Payment:    2493985 total     12021.99 txn/s    721319.19 txn/m
              New Order:    2609640 total     12579.49 txn/s    754769.31 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 74.17 ms
 - Median Latency = 53 ms
 - 75-th Percentile Latency = 69 ms
 - 90-th Percentile Latency = 127 ms
 - 95-th Percentile Latency = 146 ms
 - 99-th Percentile Latency = 219 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 206565 ms
Total transactions: 5800000
Transactions per second: 28078.33
            Stock Level:     232560 total      1125.84 txn/s     67550.65 txn/m
               Delivery:     231959 total      1122.93 txn/s     67376.08 txn/m
           Order Status:     231856 total      1122.44 txn/s     67346.16 txn/m
                Payment:    2493985 total     12073.61 txn/s    724416.56 txn/m
              New Order:    2609640 total     12633.50 txn/s    758010.31 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 73.96 ms
 - Median Latency = 53 ms
 - 75-th Percentile Latency = 69 ms
 - 90-th Percentile Latency = 131 ms
 - 95-th Percentile Latency = 148 ms
 - 99-th Percentile Latency = 199 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 207863 ms
Total transactions: 5800000
Transactions per second: 27902.99
            Stock Level:     232560 total      1118.81 txn/s     67128.83 txn/m
               Delivery:     231959 total      1115.92 txn/s     66955.35 txn/m
           Order Status:     231856 total      1115.43 txn/s     66925.62 txn/m
                Payment:    2493985 total     11998.21 txn/s    719892.94 txn/m
              New Order:    2609640 total     12554.62 txn/s    753276.88 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 74.34 ms
 - Median Latency = 53 ms
 - 75-th Percentile Latency = 69 ms
 - 90-th Percentile Latency = 130 ms
 - 95-th Percentile Latency = 148 ms
 - 99-th Percentile Latency = 207 ms
=================================================================================
```

### 6GB local DRAM, 80GB remote DRAM

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 214758 ms
Total transactions: 5800000
Transactions per second: 27007.14
            Stock Level:     232560 total      1082.89 txn/s     64973.60 txn/m
               Delivery:     231959 total      1080.09 txn/s     64805.69 txn/m
           Order Status:     231856 total      1079.62 txn/s     64776.91 txn/m
                Payment:    2493985 total     11613.00 txn/s    696780.13 txn/m
              New Order:    2609640 total     12151.54 txn/s    729092.31 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 76.89 ms
 - Median Latency = 55 ms
 - 75-th Percentile Latency = 73 ms
 - 90-th Percentile Latency = 131 ms
 - 95-th Percentile Latency = 150 ms
 - 99-th Percentile Latency = 217 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 214024 ms
Total transactions: 5800000
Transactions per second: 27099.76
            Stock Level:     232560 total      1086.61 txn/s     65196.43 txn/m
               Delivery:     231959 total      1083.80 txn/s     65027.94 txn/m
           Order Status:     231856 total      1083.32 txn/s     64999.07 txn/m
                Payment:    2493985 total     11652.83 txn/s    699169.75 txn/m
              New Order:    2609640 total     12193.21 txn/s    731592.69 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 76.59 ms
 - Median Latency = 55 ms
 - 75-th Percentile Latency = 71 ms
 - 90-th Percentile Latency = 135 ms
 - 95-th Percentile Latency = 153 ms
 - 99-th Percentile Latency = 221 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 214621 ms
Total transactions: 5800000
Transactions per second: 27024.38
            Stock Level:     232560 total      1083.58 txn/s     65015.07 txn/m
               Delivery:     231959 total      1080.78 txn/s     64847.05 txn/m
           Order Status:     231856 total      1080.30 txn/s     64818.26 txn/m
                Payment:    2493985 total     11620.41 txn/s    697224.88 txn/m
              New Order:    2609640 total     12159.29 txn/s    729557.69 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 76.83 ms
 - Median Latency = 55 ms
 - 75-th Percentile Latency = 71 ms
 - 90-th Percentile Latency = 135 ms
 - 95-th Percentile Latency = 153 ms
 - 99-th Percentile Latency = 215 ms
=================================================================================
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
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 219322 ms
Total transactions: 5800000
Transactions per second: 26445.13
            Stock Level:     232560 total      1060.36 txn/s     63621.52 txn/m
               Delivery:     231959 total      1057.62 txn/s     63457.11 txn/m
           Order Status:     231856 total      1057.15 txn/s     63428.93 txn/m
                Payment:    2493985 total     11371.34 txn/s    682280.38 txn/m
              New Order:    2609640 total     11898.67 txn/s    713920.13 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 78.55 ms
 - Median Latency = 57 ms
 - 75-th Percentile Latency = 75 ms
 - 90-th Percentile Latency = 136 ms
 - 95-th Percentile Latency = 156 ms
 - 99-th Percentile Latency = 219 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 218765 ms
Total transactions: 5800000
Transactions per second: 26512.47
            Stock Level:     232560 total      1063.06 txn/s     63783.51 txn/m
               Delivery:     231959 total      1060.31 txn/s     63618.68 txn/m
           Order Status:     231856 total      1059.84 txn/s     63590.43 txn/m
                Payment:    2493985 total     11400.29 txn/s    684017.56 txn/m
              New Order:    2609640 total     11928.96 txn/s    715737.88 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 78.41 ms
 - Median Latency = 56 ms
 - 75-th Percentile Latency = 73 ms
 - 90-th Percentile Latency = 137 ms
 - 95-th Percentile Latency = 156 ms
 - 99-th Percentile Latency = 224 ms
=================================================================================
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
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 218774 ms
Total transactions: 5800000
Transactions per second: 26511.38
            Stock Level:     232560 total      1063.01 txn/s     63780.89 txn/m
               Delivery:     231959 total      1060.27 txn/s     63616.06 txn/m
           Order Status:     231856 total      1059.80 txn/s     63587.81 txn/m
                Payment:    2493985 total     11399.82 txn/s    683989.44 txn/m
              New Order:    2609640 total     11928.47 txn/s    715708.44 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 78.38 ms
 - Median Latency = 56 ms
 - 75-th Percentile Latency = 73 ms
 - 90-th Percentile Latency = 138 ms
 - 95-th Percentile Latency = 157 ms
 - 99-th Percentile Latency = 228 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 223391 ms
Total transactions: 5800000
Transactions per second: 25963.45
            Stock Level:     232560 total      1041.04 txn/s     62462.68 txn/m
               Delivery:     231959 total      1038.35 txn/s     62301.25 txn/m
           Order Status:     231856 total      1037.89 txn/s     62273.59 txn/m
                Payment:    2493985 total     11164.21 txn/s    669852.88 txn/m
              New Order:    2609640 total     11681.94 txn/s    700916.31 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 80.08 ms
 - Median Latency = 57 ms
 - 75-th Percentile Latency = 75 ms
 - 90-th Percentile Latency = 143 ms
 - 95-th Percentile Latency = 161 ms
 - 99-th Percentile Latency = 238 ms
=================================================================================
```
