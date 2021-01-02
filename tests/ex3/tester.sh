#!/bin/bash

OUTDIR=temp_out
MJAVAC=../../mjavac.jar

function run {

    INFILE=$2/$1.xml
    OUTFILE=$OUTDIR/$1.txt

    java -jar $MJAVAC unmarshal semantic $INFILE $OUTFILE

    echo -n "$1: "

    if [[ "$2" = "valid" ]]; then
        EXPECTED=ok.txt
    else
        EXPECTED=error.txt
    fi

    DIFF=$(diff $OUTFILE $EXPECTED)

    if [[ $DIFF != "" ]]; then
        echo Failed
        echo "Expected: $(cat $EXPECTED)"
        echo "Received: $(cat $OUTFILE)"
    else
        echo Success
    fi

    echo
}

run $1 $2


