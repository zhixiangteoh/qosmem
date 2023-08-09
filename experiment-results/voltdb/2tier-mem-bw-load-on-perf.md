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

"resting" mem b/w, i.e., MBL (MB/s): 14.4

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 179986 ms
Total transactions: 5800000
Transactions per second: 32224.73
            Stock Level:     232560 total      1292.10 txn/s     77526.03 txn/m
               Delivery:     231959 total      1288.76 txn/s     77325.69 txn/m
           Order Status:     231856 total      1288.19 txn/s     77291.35 txn/m
                Payment:    2493985 total     13856.55 txn/s    831393.06 txn/m
              New Order:    2609640 total     14499.13 txn/s    869947.69 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 64.12 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 44 ms
 - 50-th Percentile Latency = 48 ms
 - 75-th Percentile Latency = 62 ms
 - 90-th Percentile Latency = 114 ms
 - 95-th Percentile Latency = 131 ms
 - 99-th Percentile Latency = 160 ms
 - Max Latency = 3450 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 181133 ms
Total transactions: 5800000
Transactions per second: 32020.67
            Stock Level:     232560 total      1283.92 txn/s     77035.11 txn/m
               Delivery:     231959 total      1280.60 txn/s     76836.03 txn/m
           Order Status:     231856 total      1280.03 txn/s     76801.91 txn/m
                Payment:    2493985 total     13768.81 txn/s    826128.38 txn/m
              New Order:    2609640 total     14407.31 txn/s    864438.88 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 64.57 ms
 - Min Latency = 3 ms
 - 25-th Percentile Latency = 43 ms
 - 50-th Percentile Latency = 48 ms
 - 75-th Percentile Latency = 63 ms
 - 90-th Percentile Latency = 116 ms
 - 95-th Percentile Latency = 132 ms
 - 99-th Percentile Latency = 161 ms
 - Max Latency = 4114 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 180467 ms
Total transactions: 5800000
Transactions per second: 32138.84
            Stock Level:     232560 total      1288.66 txn/s     77319.40 txn/m
               Delivery:     231959 total      1285.33 txn/s     77119.59 txn/m
           Order Status:     231856 total      1284.76 txn/s     77085.34 txn/m
                Payment:    2493985 total     13819.62 txn/s    829177.13 txn/m
              New Order:    2609640 total     14460.48 txn/s    867629.00 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 64.23 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 43 ms
 - 50-th Percentile Latency = 48 ms
 - 75-th Percentile Latency = 64 ms
 - 90-th Percentile Latency = 110 ms
 - 95-th Percentile Latency = 128 ms
 - 99-th Percentile Latency = 159 ms
 - Max Latency = 4242 ms
=================================================================================
```

---

### 1 local CPU core running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 182576 ms
Total transactions: 5800000
Transactions per second: 31767.59
            Stock Level:     232560 total      1273.77 txn/s     76426.25 txn/m
               Delivery:     231959 total      1270.48 txn/s     76228.75 txn/m
           Order Status:     231856 total      1269.91 txn/s     76194.90 txn/m
                Payment:    2493985 total     13659.98 txn/s    819598.94 txn/m
              New Order:    2609640 total     14293.44 txn/s    857606.69 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 65.06 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 44 ms
 - 50-th Percentile Latency = 48 ms
 - 75-th Percentile Latency = 64 ms
 - 90-th Percentile Latency = 117 ms
 - 95-th Percentile Latency = 133 ms
 - 99-th Percentile Latency = 163 ms
 - Max Latency = 3136 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 181094 ms
Total transactions: 5800000
Transactions per second: 32027.57
            Stock Level:     232560 total      1284.19 txn/s     77051.70 txn/m
               Delivery:     231959 total      1280.88 txn/s     76852.58 txn/m
           Order Status:     231856 total      1280.31 txn/s     76818.45 txn/m
                Payment:    2493985 total     13771.77 txn/s    826306.25 txn/m
              New Order:    2609640 total     14410.42 txn/s    864625.00 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 64.43 ms
 - Min Latency = 2 ms
 - 25-th Percentile Latency = 44 ms
 - 50-th Percentile Latency = 49 ms
 - 75-th Percentile Latency = 63 ms
 - 90-th Percentile Latency = 109 ms
 - 95-th Percentile Latency = 126 ms
 - 99-th Percentile Latency = 154 ms
 - Max Latency = 3930 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 183344 ms
Total transactions: 5800000
Transactions per second: 31634.52
            Stock Level:     232560 total      1268.44 txn/s     76106.12 txn/m
               Delivery:     231959 total      1265.16 txn/s     75909.44 txn/m
           Order Status:     231856 total      1264.60 txn/s     75875.73 txn/m
                Payment:    2493985 total     13602.76 txn/s    816165.81 txn/m
              New Order:    2609640 total     14233.57 txn/s    854014.31 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 65.36 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 44 ms
 - 50-th Percentile Latency = 49 ms
 - 75-th Percentile Latency = 65 ms
 - 90-th Percentile Latency = 111 ms
 - 95-th Percentile Latency = 130 ms
 - 99-th Percentile Latency = 161 ms
 - Max Latency = 4011 ms
=================================================================================
```

### 2 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 183276 ms
Total transactions: 5800000
Transactions per second: 31646.26
            Stock Level:     232560 total      1268.91 txn/s     76134.35 txn/m
               Delivery:     231959 total      1265.63 txn/s     75937.60 txn/m
           Order Status:     231856 total      1265.06 txn/s     75903.88 txn/m
                Payment:    2493985 total     13607.81 txn/s    816468.63 txn/m
              New Order:    2609640 total     14238.85 txn/s    854331.19 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 65.22 ms
 - Min Latency = 6 ms
 - 25-th Percentile Latency = 44 ms
 - 50-th Percentile Latency = 49 ms
 - 75-th Percentile Latency = 65 ms
 - 90-th Percentile Latency = 110 ms
 - 95-th Percentile Latency = 128 ms
 - 99-th Percentile Latency = 159 ms
 - Max Latency = 4169 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 183724 ms
Total transactions: 5800000
Transactions per second: 31569.09
            Stock Level:     232560 total      1265.81 txn/s     75948.70 txn/m
               Delivery:     231959 total      1262.54 txn/s     75752.43 txn/m
           Order Status:     231856 total      1261.98 txn/s     75718.80 txn/m
                Payment:    2493985 total     13574.63 txn/s    814477.75 txn/m
              New Order:    2609640 total     14204.13 txn/s    852247.94 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 65.44 ms
 - Min Latency = 5 ms
 - 25-th Percentile Latency = 44 ms
 - 50-th Percentile Latency = 49 ms
 - 75-th Percentile Latency = 65 ms
 - 90-th Percentile Latency = 112 ms
 - 95-th Percentile Latency = 130 ms
 - 99-th Percentile Latency = 159 ms
 - Max Latency = 4280 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 182268 ms
Total transactions: 5800000
Transactions per second: 31821.27
            Stock Level:     232560 total      1275.92 txn/s     76555.40 txn/m
               Delivery:     231959 total      1272.63 txn/s     76357.56 txn/m
           Order Status:     231856 total      1272.06 txn/s     76323.66 txn/m
                Payment:    2493985 total     13683.07 txn/s    820983.94 txn/m
              New Order:    2609640 total     14317.60 txn/s    859055.88 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 65.02 ms
 - Min Latency = 2 ms
 - 25-th Percentile Latency = 44 ms
 - 50-th Percentile Latency = 49 ms
 - 75-th Percentile Latency = 63 ms
 - 90-th Percentile Latency = 116 ms
 - 95-th Percentile Latency = 133 ms
 - 99-th Percentile Latency = 160 ms
 - Max Latency = 3106 ms
=================================================================================
```

### 4 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 181784 ms
Total transactions: 5800000
Transactions per second: 31906.00
            Stock Level:     232560 total      1279.32 txn/s     76759.23 txn/m
               Delivery:     231959 total      1276.01 txn/s     76560.87 txn/m
           Order Status:     231856 total      1275.45 txn/s     76526.87 txn/m
                Payment:    2493985 total     13719.50 txn/s    823169.81 txn/m
              New Order:    2609640 total     14355.72 txn/s    861343.13 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 64.89 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 44 ms
 - 50-th Percentile Latency = 49 ms
 - 75-th Percentile Latency = 62 ms
 - 90-th Percentile Latency = 116 ms
 - 95-th Percentile Latency = 133 ms
 - 99-th Percentile Latency = 159 ms
 - Max Latency = 3020 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 184287 ms
Total transactions: 5800000
Transactions per second: 31472.65
            Stock Level:     232560 total      1261.94 txn/s     75716.68 txn/m
               Delivery:     231959 total      1258.68 txn/s     75521.01 txn/m
           Order Status:     231856 total      1258.12 txn/s     75487.47 txn/m
                Payment:    2493985 total     13533.16 txn/s    811989.44 txn/m
              New Order:    2609640 total     14160.74 txn/s    849644.31 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 65.74 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 45 ms
 - 50-th Percentile Latency = 49 ms
 - 75-th Percentile Latency = 63 ms
 - 90-th Percentile Latency = 116 ms
 - 95-th Percentile Latency = 133 ms
 - 99-th Percentile Latency = 162 ms
 - Max Latency = 3434 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 181034 ms
Total transactions: 5800000
Transactions per second: 32038.18
            Stock Level:     232560 total      1284.62 txn/s     77077.23 txn/m
               Delivery:     231959 total      1281.30 txn/s     76878.05 txn/m
           Order Status:     231856 total      1280.73 txn/s     76843.91 txn/m
                Payment:    2493985 total     13776.33 txn/s    826580.13 txn/m
              New Order:    2609640 total     14415.19 txn/s    864911.56 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 64.72 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 45 ms
 - 50-th Percentile Latency = 49 ms
 - 75-th Percentile Latency = 63 ms
 - 90-th Percentile Latency = 113 ms
 - 95-th Percentile Latency = 131 ms
 - 99-th Percentile Latency = 158 ms
 - Max Latency = 2439 ms
=================================================================================
```

### 8 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 184815 ms
Total transactions: 5800000
Transactions per second: 31382.73
            Stock Level:     232560 total      1258.34 txn/s     75500.37 txn/m
               Delivery:     231959 total      1255.09 txn/s     75305.25 txn/m
           Order Status:     231856 total      1254.53 txn/s     75271.81 txn/m
                Payment:    2493985 total     13494.49 txn/s    809669.69 txn/m
              New Order:    2609640 total     14120.28 txn/s    847216.94 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 66.22 ms
 - Min Latency = 3 ms
 - 25-th Percentile Latency = 45 ms
 - 50-th Percentile Latency = 49 ms
 - 75-th Percentile Latency = 64 ms
 - 90-th Percentile Latency = 115 ms
 - 95-th Percentile Latency = 135 ms
 - 99-th Percentile Latency = 166 ms
 - Max Latency = 3332 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 186751 ms
Total transactions: 5800000
Transactions per second: 31057.40
            Stock Level:     232560 total      1245.29 txn/s     74717.67 txn/m
               Delivery:     231959 total      1242.08 txn/s     74524.58 txn/m
           Order Status:     231856 total      1241.52 txn/s     74491.48 txn/m
                Payment:    2493985 total     13354.60 txn/s    801276.00 txn/m
              New Order:    2609640 total     13973.90 txn/s    838434.06 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 66.81 ms
 - Min Latency = 1 ms
 - 25-th Percentile Latency = 45 ms
 - 50-th Percentile Latency = 50 ms
 - 75-th Percentile Latency = 63 ms
 - 90-th Percentile Latency = 120 ms
 - 95-th Percentile Latency = 139 ms
 - 99-th Percentile Latency = 168 ms
 - Max Latency = 3295 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 185347 ms
Total transactions: 5800000
Transactions per second: 31292.66
            Stock Level:     232560 total      1254.73 txn/s     75283.66 txn/m
               Delivery:     231959 total      1251.49 txn/s     75089.10 txn/m
           Order Status:     231856 total      1250.93 txn/s     75055.76 txn/m
                Payment:    2493985 total     13455.76 txn/s    807345.69 txn/m
              New Order:    2609640 total     14079.75 txn/s    844785.19 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 66.44 ms
 - Min Latency = 2 ms
 - 25-th Percentile Latency = 45 ms
 - 50-th Percentile Latency = 50 ms
 - 75-th Percentile Latency = 63 ms
 - 90-th Percentile Latency = 118 ms
 - 95-th Percentile Latency = 137 ms
 - 99-th Percentile Latency = 163 ms
 - Max Latency = 3183 ms
=================================================================================
```

### 12 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 190169 ms
Total transactions: 5800000
Transactions per second: 30499.19
            Stock Level:     232560 total      1222.91 txn/s     73374.73 txn/m
               Delivery:     231959 total      1219.75 txn/s     73185.11 txn/m
           Order Status:     231856 total      1219.21 txn/s     73152.62 txn/m
                Payment:    2493985 total     13114.57 txn/s    786874.31 txn/m
              New Order:    2609640 total     13722.74 txn/s    823364.44 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 68.25 ms
 - Min Latency = 6 ms
 - 25-th Percentile Latency = 45 ms
 - 50-th Percentile Latency = 50 ms
 - 75-th Percentile Latency = 66 ms
 - 90-th Percentile Latency = 124 ms
 - 95-th Percentile Latency = 146 ms
 - 99-th Percentile Latency = 182 ms
 - Max Latency = 3336 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 189713 ms
Total transactions: 5800000
Transactions per second: 30572.50
            Stock Level:     232560 total      1225.85 txn/s     73551.10 txn/m
               Delivery:     231959 total      1222.68 txn/s     73361.02 txn/m
           Order Status:     231856 total      1222.14 txn/s     73328.45 txn/m
                Payment:    2493985 total     13146.09 txn/s    788765.69 txn/m
              New Order:    2609640 total     13755.73 txn/s    825343.56 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 68.12 ms
 - Min Latency = 3 ms
 - 25-th Percentile Latency = 44 ms
 - 50-th Percentile Latency = 50 ms
 - 75-th Percentile Latency = 66 ms
 - 90-th Percentile Latency = 123 ms
 - 95-th Percentile Latency = 145 ms
 - 99-th Percentile Latency = 182 ms
 - Max Latency = 3615 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 189850 ms
Total transactions: 5800000
Transactions per second: 30550.43
            Stock Level:     232560 total      1224.97 txn/s     73498.02 txn/m
               Delivery:     231959 total      1221.80 txn/s     73308.09 txn/m
           Order Status:     231856 total      1221.26 txn/s     73275.53 txn/m
                Payment:    2493985 total     13136.61 txn/s    788196.44 txn/m
              New Order:    2609640 total     13745.80 txn/s    824747.94 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 68.12 ms
 - Min Latency = 5 ms
 - 25-th Percentile Latency = 45 ms
 - 50-th Percentile Latency = 50 ms
 - 75-th Percentile Latency = 67 ms
 - 90-th Percentile Latency = 122 ms
 - 95-th Percentile Latency = 144 ms
 - 99-th Percentile Latency = 181 ms
 - Max Latency = 3657 ms
=================================================================================
```

### 16 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 99243.6

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 178891 ms
Total transactions: 5800000
Transactions per second: 32421.98
            Stock Level:     232560 total      1300.01 txn/s     78000.57 txn/m
               Delivery:     231959 total      1296.65 txn/s     77798.99 txn/m
           Order Status:     231856 total      1296.07 txn/s     77764.45 txn/m
                Payment:    2493985 total     13941.37 txn/s    836482.00 txn/m
              New Order:    2609640 total     14587.88 txn/s    875272.63 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 64.16 ms
 - Min Latency = 3 ms
 - 25-th Percentile Latency = 41 ms
 - 50-th Percentile Latency = 46 ms
 - 75-th Percentile Latency = 61 ms
 - 90-th Percentile Latency = 111 ms
 - 95-th Percentile Latency = 140 ms
 - 99-th Percentile Latency = 190 ms
 - Max Latency = 3496 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 183733 ms
Total transactions: 5800000
Transactions per second: 31567.55
            Stock Level:     232560 total      1265.75 txn/s     75944.98 txn/m
               Delivery:     231959 total      1262.48 txn/s     75748.72 txn/m
           Order Status:     231856 total      1261.92 txn/s     75715.09 txn/m
                Payment:    2493985 total     13573.96 txn/s    814437.81 txn/m
              New Order:    2609640 total     14203.44 txn/s    852206.19 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 65.90 ms
 - Min Latency = 2 ms
 - 25-th Percentile Latency = 41 ms
 - 50-th Percentile Latency = 46 ms
 - 75-th Percentile Latency = 61 ms
 - 90-th Percentile Latency = 120 ms
 - 95-th Percentile Latency = 151 ms
 - 99-th Percentile Latency = 198 ms
 - Max Latency = 3699 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 181262 ms
Total transactions: 5800000
Transactions per second: 31997.88
            Stock Level:     232560 total      1283.00 txn/s     76980.29 txn/m
               Delivery:     231959 total      1279.69 txn/s     76781.34 txn/m
           Order Status:     231856 total      1279.12 txn/s     76747.25 txn/m
                Payment:    2493985 total     13759.01 txn/s    825540.44 txn/m
              New Order:    2609640 total     14397.06 txn/s    863823.69 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 65.04 ms
 - Min Latency = 3 ms
 - 25-th Percentile Latency = 41 ms
 - 50-th Percentile Latency = 46 ms
 - 75-th Percentile Latency = 62 ms
 - 90-th Percentile Latency = 113 ms
 - 95-th Percentile Latency = 143 ms
 - 99-th Percentile Latency = 190 ms
 - Max Latency = 4113 ms
=================================================================================
```

### 20 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 189736 ms
Total transactions: 5800000
Transactions per second: 30568.79
            Stock Level:     232560 total      1225.70 txn/s     73542.19 txn/m
               Delivery:     231959 total      1222.54 txn/s     73352.13 txn/m
           Order Status:     231856 total      1221.99 txn/s     73319.56 txn/m
                Payment:    2493985 total     13144.50 txn/s    788670.13 txn/m
              New Order:    2609640 total     13754.06 txn/s    825243.50 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 68.09 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 44 ms
 - 50-th Percentile Latency = 49 ms
 - 75-th Percentile Latency = 65 ms
 - 90-th Percentile Latency = 116 ms
 - 95-th Percentile Latency = 148 ms
 - 99-th Percentile Latency = 196 ms
 - Max Latency = 3821 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 191204 ms
Total transactions: 5800000
Transactions per second: 30334.09
            Stock Level:     232560 total      1216.29 txn/s     72977.55 txn/m
               Delivery:     231959 total      1213.15 txn/s     72788.96 txn/m
           Order Status:     231856 total      1212.61 txn/s     72756.64 txn/m
                Payment:    2493985 total     13043.58 txn/s    782614.94 txn/m
              New Order:    2609640 total     13648.46 txn/s    818907.56 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 68.62 ms
 - Min Latency = 0 ms
 - 25-th Percentile Latency = 45 ms
 - 50-th Percentile Latency = 50 ms
 - 75-th Percentile Latency = 66 ms
 - 90-th Percentile Latency = 115 ms
 - 95-th Percentile Latency = 150 ms
 - 99-th Percentile Latency = 199 ms
 - Max Latency = 4222 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 198782 ms
Total transactions: 5800000
Transactions per second: 29177.69
            Stock Level:     232560 total      1169.92 txn/s     70195.49 txn/m
               Delivery:     231959 total      1166.90 txn/s     70014.09 txn/m
           Order Status:     231856 total      1166.38 txn/s     69983.00 txn/m
                Payment:    2493985 total     12546.33 txn/s    752779.94 txn/m
              New Order:    2609640 total     13128.15 txn/s    787689.06 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 71.41 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 45 ms
 - 50-th Percentile Latency = 51 ms
 - 75-th Percentile Latency = 65 ms
 - 90-th Percentile Latency = 132 ms
 - 95-th Percentile Latency = 164 ms
 - 99-th Percentile Latency = 203 ms
 - Max Latency = 4748 ms
=================================================================================
```

### 24 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 100331.1
"running" mem b/w, i.e., MBL (MB/s): 93219.3

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 199849 ms
Total transactions: 5800000
Transactions per second: 29021.91
            Stock Level:     232560 total      1163.68 txn/s     69820.72 txn/m
               Delivery:     231959 total      1160.67 txn/s     69640.28 txn/m
           Order Status:     231856 total      1160.16 txn/s     69609.35 txn/m
                Payment:    2493985 total     12479.35 txn/s    748760.81 txn/m
              New Order:    2609640 total     13058.06 txn/s    783483.56 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 71.66 ms
 - Min Latency = 0 ms
 - 25-th Percentile Latency = 49 ms
 - 50-th Percentile Latency = 55 ms
 - 75-th Percentile Latency = 71 ms
 - 90-th Percentile Latency = 102 ms
 - 95-th Percentile Latency = 133 ms
 - 99-th Percentile Latency = 200 ms
 - Max Latency = 4801 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 201539 ms
Total transactions: 5800000
Transactions per second: 28778.55
            Stock Level:     232560 total      1153.92 txn/s     69235.23 txn/m
               Delivery:     231959 total      1150.94 txn/s     69056.31 txn/m
           Order Status:     231856 total      1150.43 txn/s     69025.65 txn/m
                Payment:    2493985 total     12374.70 txn/s    742482.13 txn/m
              New Order:    2609640 total     12948.56 txn/s    776913.63 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 72.26 ms
 - Min Latency = 6 ms
 - 25-th Percentile Latency = 49 ms
 - 50-th Percentile Latency = 55 ms
 - 75-th Percentile Latency = 72 ms
 - 90-th Percentile Latency = 105 ms
 - 95-th Percentile Latency = 132 ms
 - 99-th Percentile Latency = 200 ms
 - Max Latency = 4675 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 196449 ms
Total transactions: 5800000
Transactions per second: 29524.20
            Stock Level:     232560 total      1183.82 txn/s     71029.12 txn/m
               Delivery:     231959 total      1180.76 txn/s     70845.56 txn/m
           Order Status:     231856 total      1180.23 txn/s     70814.10 txn/m
                Payment:    2493985 total     12695.33 txn/s    761719.81 txn/m
              New Order:    2609640 total     13284.06 txn/s    797043.50 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 70.43 ms
 - Min Latency = 9 ms
 - 25-th Percentile Latency = 49 ms
 - 50-th Percentile Latency = 55 ms
 - 75-th Percentile Latency = 71 ms
 - 90-th Percentile Latency = 99 ms
 - 95-th Percentile Latency = 122 ms
 - 99-th Percentile Latency = 209 ms
 - Max Latency = 4374 ms
=================================================================================
```

### 28 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 99345.9
"running" mem b/w, i.e., MBL (MB/s): 94854.1

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 265987 ms
Total transactions: 5800000
Transactions per second: 21805.58
            Stock Level:     232560 total       874.33 txn/s     52459.71 txn/m
               Delivery:     231959 total       872.07 txn/s     52324.14 txn/m
           Order Status:     231856 total       871.68 txn/s     52300.90 txn/m
                Payment:    2493985 total      9376.34 txn/s    562580.50 txn/m
              New Order:    2609640 total      9811.16 txn/s    588669.38 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 95.49 ms
 - Min Latency = 1 ms
 - 25-th Percentile Latency = 66 ms
 - 50-th Percentile Latency = 79 ms
 - 75-th Percentile Latency = 102 ms
 - 90-th Percentile Latency = 133 ms
 - 95-th Percentile Latency = 158 ms
 - 99-th Percentile Latency = 252 ms
 - Max Latency = 5490 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 264407 ms
Total transactions: 5800000
Transactions per second: 21935.88
            Stock Level:     232560 total       879.55 txn/s     52773.18 txn/m
               Delivery:     231959 total       877.28 txn/s     52636.80 txn/m
           Order Status:     231856 total       876.89 txn/s     52613.43 txn/m
                Payment:    2493985 total      9432.37 txn/s    565942.25 txn/m
              New Order:    2609640 total      9869.78 txn/s    592187.00 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 94.87 ms
 - Min Latency = 3 ms
 - 25-th Percentile Latency = 66 ms
 - 50-th Percentile Latency = 79 ms
 - 75-th Percentile Latency = 102 ms
 - 90-th Percentile Latency = 133 ms
 - 95-th Percentile Latency = 158 ms
 - 99-th Percentile Latency = 240 ms
 - Max Latency = 5474 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 266624 ms
Total transactions: 5800000
Transactions per second: 21753.48
            Stock Level:     232560 total       872.24 txn/s     52334.38 txn/m
               Delivery:     231959 total       869.99 txn/s     52199.13 txn/m
           Order Status:     231856 total       869.60 txn/s     52175.95 txn/m
                Payment:    2493985 total      9353.94 txn/s    561236.44 txn/m
              New Order:    2609640 total      9787.72 txn/s    587263.00 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 95.52 ms
 - Min Latency = 9 ms
 - 25-th Percentile Latency = 66 ms
 - 50-th Percentile Latency = 80 ms
 - 75-th Percentile Latency = 102 ms
 - 90-th Percentile Latency = 134 ms
 - 95-th Percentile Latency = 159 ms
 - 99-th Percentile Latency = 262 ms
 - Max Latency = 5336 ms
=================================================================================
```

### 30 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 272820 ms
Total transactions: 5800000
Transactions per second: 21259.44
            Stock Level:     232560 total       852.43 txn/s     51145.81 txn/m
               Delivery:     231959 total       850.23 txn/s     51013.63 txn/m
           Order Status:     231856 total       849.85 txn/s     50990.98 txn/m
                Payment:    2493985 total      9141.50 txn/s    548490.19 txn/m
              New Order:    2609640 total      9565.43 txn/s    573925.63 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 97.96 ms
 - Min Latency = 7 ms
 - 25-th Percentile Latency = 66 ms
 - 50-th Percentile Latency = 79 ms
 - 75-th Percentile Latency = 103 ms
 - 90-th Percentile Latency = 143 ms
 - 95-th Percentile Latency = 174 ms
 - 99-th Percentile Latency = 292 ms
 - Max Latency = 5772 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 272465 ms
Total transactions: 5800000
Transactions per second: 21287.14
            Stock Level:     232560 total       853.54 txn/s     51212.45 txn/m
               Delivery:     231959 total       851.34 txn/s     51080.10 txn/m
           Order Status:     231856 total       850.96 txn/s     51057.42 txn/m
                Payment:    2493985 total      9153.41 txn/s    549204.88 txn/m
              New Order:    2609640 total      9577.89 txn/s    574673.44 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 97.80 ms
 - Min Latency = 5 ms
 - 25-th Percentile Latency = 66 ms
 - 50-th Percentile Latency = 79 ms
 - 75-th Percentile Latency = 102 ms
 - 90-th Percentile Latency = 141 ms
 - 95-th Percentile Latency = 173 ms
 - 99-th Percentile Latency = 293 ms
 - Max Latency = 5908 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 269619 ms
Total transactions: 5800000
Transactions per second: 21511.84
            Stock Level:     232560 total       862.55 txn/s     51753.03 txn/m
               Delivery:     231959 total       860.32 txn/s     51619.29 txn/m
           Order Status:     231856 total       859.94 txn/s     51596.37 txn/m
                Payment:    2493985 total      9250.04 txn/s    555002.13 txn/m
              New Order:    2609640 total      9678.99 txn/s    580739.50 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 96.82 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 66 ms
 - 50-th Percentile Latency = 79 ms
 - 75-th Percentile Latency = 102 ms
 - 90-th Percentile Latency = 139 ms
 - 95-th Percentile Latency = 169 ms
 - 99-th Percentile Latency = 274 ms
 - Max Latency = 5607 ms
=================================================================================
```

### 31 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 279929 ms
Total transactions: 5800000
Transactions per second: 20719.54
            Stock Level:     232560 total       830.78 txn/s     49846.93 txn/m
               Delivery:     231959 total       828.64 txn/s     49718.11 txn/m
           Order Status:     231856 total       828.27 txn/s     49696.03 txn/m
                Payment:    2493985 total      8909.35 txn/s    534560.94 txn/m
              New Order:    2609640 total      9322.51 txn/s    559350.44 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 100.47 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 66 ms
 - 50-th Percentile Latency = 80 ms
 - 75-th Percentile Latency = 104 ms
 - 90-th Percentile Latency = 149 ms
 - 95-th Percentile Latency = 187 ms
 - 99-th Percentile Latency = 304 ms
 - Max Latency = 5814 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 277563 ms
Total transactions: 5800000
Transactions per second: 20896.16
            Stock Level:     232560 total       837.86 txn/s     50271.83 txn/m
               Delivery:     231959 total       835.70 txn/s     50141.91 txn/m
           Order Status:     231856 total       835.33 txn/s     50119.65 txn/m
                Payment:    2493985 total      8985.29 txn/s    539117.63 txn/m
              New Order:    2609640 total      9401.97 txn/s    564118.44 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 99.62 ms
 - Min Latency = 2 ms
 - 25-th Percentile Latency = 66 ms
 - 50-th Percentile Latency = 79 ms
 - 75-th Percentile Latency = 103 ms
 - 90-th Percentile Latency = 150 ms
 - 95-th Percentile Latency = 189 ms
 - 99-th Percentile Latency = 304 ms
 - Max Latency = 5777 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 277197 ms
Total transactions: 5800000
Transactions per second: 20923.75
            Stock Level:     232560 total       838.97 txn/s     50338.21 txn/m
               Delivery:     231959 total       836.80 txn/s     50208.12 txn/m
           Order Status:     231856 total       836.43 txn/s     50185.82 txn/m
                Payment:    2493985 total      8997.16 txn/s    539829.44 txn/m
              New Order:    2609640 total      9414.39 txn/s    564863.25 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 99.51 ms
 - Min Latency = 7 ms
 - 25-th Percentile Latency = 66 ms
 - 50-th Percentile Latency = 79 ms
 - 75-th Percentile Latency = 103 ms
 - 90-th Percentile Latency = 149 ms
 - 95-th Percentile Latency = 187 ms
 - 99-th Percentile Latency = 299 ms
 - Max Latency = 5740 ms
=================================================================================
```

### 32 local CPU cores running `test_page_frequency`

"resting" mem b/w, i.e., MBL (MB/s): 97268.6
"running" mem b/w, i.e., MBL (MB/s):

#### Run 1
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 285787 ms
Total transactions: 5800000
Transactions per second: 20294.84
            Stock Level:     232560 total       813.75 txn/s     48825.18 txn/m
               Delivery:     231959 total       811.65 txn/s     48699.00 txn/m
           Order Status:     231856 total       811.29 txn/s     48677.38 txn/m
                Payment:    2493985 total      8726.73 txn/s    523603.63 txn/m
              New Order:    2609640 total      9131.42 txn/s    547885.00 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 102.51 ms
 - Min Latency = 13 ms
 - 25-th Percentile Latency = 65 ms
 - 50-th Percentile Latency = 78 ms
 - 75-th Percentile Latency = 103 ms
 - 90-th Percentile Latency = 172 ms
 - 95-th Percentile Latency = 229 ms
 - 99-th Percentile Latency = 334 ms
 - Max Latency = 5767 ms
=================================================================================
```

#### Run 2
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 291223 ms
Total transactions: 5800000
Transactions per second: 19916.01
            Stock Level:     232560 total       798.56 txn/s     47913.80 txn/m
               Delivery:     231959 total       796.50 txn/s     47789.98 txn/m
           Order Status:     231856 total       796.15 txn/s     47768.75 txn/m
                Payment:    2493985 total      8563.83 txn/s    513829.97 txn/m
              New Order:    2609640 total      8960.97 txn/s    537658.13 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 104.53 ms
 - Min Latency = 5 ms
 - 25-th Percentile Latency = 66 ms
 - 50-th Percentile Latency = 79 ms
 - 75-th Percentile Latency = 104 ms
 - 90-th Percentile Latency = 174 ms
 - 95-th Percentile Latency = 239 ms
 - 99-th Percentile Latency = 352 ms
 - Max Latency = 5121 ms
=================================================================================
```

#### Run 3
```
==================================== SUMMARY ====================================
----------------------------------- BANDWIDTH -----------------------------------
Time: 286407 ms
Total transactions: 5800000
Transactions per second: 20250.90
            Stock Level:     232560 total       811.99 txn/s     48719.48 txn/m
               Delivery:     231959 total       809.89 txn/s     48593.57 txn/m
           Order Status:     231856 total       809.53 txn/s     48572.00 txn/m
                Payment:    2493985 total      8707.83 txn/s    522470.13 txn/m
              New Order:    2609640 total      9111.65 txn/s    546698.88 txn/m
        Reset Warehouse:          0 total         0.00 txn/s         0.00 txn/m
------------------------------------ LATENCY ------------------------------------
 - Average Latency = 102.88 ms
 - Min Latency = 4 ms
 - 25-th Percentile Latency = 65 ms
 - 50-th Percentile Latency = 78 ms
 - 75-th Percentile Latency = 103 ms
 - 90-th Percentile Latency = 171 ms
 - 95-th Percentile Latency = 232 ms
 - 99-th Percentile Latency = 346 ms
 - Max Latency = 5539 ms
=================================================================================
```
