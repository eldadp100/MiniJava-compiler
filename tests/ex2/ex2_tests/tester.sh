#!/bin/bash

INDIR=examples
OUTDIR=temp_out
MJAVAC=../../../mjavac.jar

function run {
    INFILE=examples/$1.xml
    OUTFILE=$OUTDIR/$1.ll
    EXE=$OUTDIR/$1
    
    java -jar $MJAVAC unmarshal compile $INFILE $OUTFILE
    clang -Wno-override-module $OUTFILE -o $EXE

    COMP_STATUS=$?

    echo -n "$1: "

    if [ $COMP_STATUS -ne 0 ]; then
        echo -e "Failed (did not compile)\n"
        return
    fi

    OUTPUT=$(./$EXE)

    if [ "$OUTPUT" = "$2" ]; then
        echo Success
    else
        echo Failed
        echo "Expected: $2"
        echo "Received: $OUTPUT"
    fi

    echo
}

mkdir -p $OUTDIR

run simple_print 3
run simple_print_mult 36
run simple_if 1
run simple_if_and 1
run factorial 3628800
run array_iota_simple 5
run array_iota_simple_oob "Out of bounds"
run array_iota_simple_neg_size "Out of bounds"

run array_iota_print_all "1
2
3
4
5
6
7
8
9
10
0"

run array_iota_print_all_oob "1
2
3
4
5
6
7
8
9
10
Out of bounds"

run array_access_in_access 0

run and_short_circuit_arr "1
0"

run and_short_circuit_arr_backward "Out of bounds"

run subclass_fields "0
0
5
0
9
0
0"

run binary_search "20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
99999
0
0
1
1
1
1
0
0
999"

run linear_search "10
11
12
13
14
15
16
17
18
9999
0
1
1
0
55"

run binary_tree "16
100000000
8
16
4
8
12
14
16
20
24
28
1
1
1
0
1
4
8
14
16
20
24
28
0
0"

run linked_list "25
10000000
39
25
10000000
22
39
25
1
0
10000000
28
22
39
25
2220000
-555
-555
28
22
25
33300000
22
25
44440000
0"

run bubble_sort "20
7
12
18
2
11
6
9
19
5
99999
2
5
6
7
9
11
12
18
19
20
0"

run quick_sort "20
7
12
18
2
11
6
9
19
5
9999
2
5
6
7
9
11
12
18
19
20
0"

run partial_overrides "0
1
2
1
0
3
4
0
3"

run empty_vtable "1
0"

run tree_visitor "16
100000000
4
8
12
14
16
20
24
28
100000000
50000000
333
333
333
28
24
333
20
16
333
333
333
14
12
8
333
4
100000000
1
1
1
0
1
4
8
14
16
20
24
28
0
0"
