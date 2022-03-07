#!/bin/sh

BASEDIR=$(dirname "$0")
source $BASEDIR/../common/pre_check.sh

SAMPLE_NAME=sample_vio
OUT_FILE="out.txt"
INPUT_FILE="tmp"
result="TEST-PASS"
check_ret=0

function verify() {
    grep_result=$(grep "exit success" $OUT_FILE)

    if [ -z "$grep_result" ]; then
        check_ret=-1
    fi
}

function clean_tmp_files() {
    rm -rf $OUT_FILE $INPUT_FILE
}

env_check
sample_check $SAMPLE_NAME
touch $INPUT_FILE

for i in $(seq 1 $TEST_TIMES)
do
    for i in 0 1 2 3 19;
    do
        echo "========== test $i =========="
        $SAMPLE_DIR/$SAMPLE_NAME $i < $INPUT_FILE | tee $OUT_FILE
        verify

        if [ $check_ret != 0 ]; then
            result="TEST-FAIL"
            break
        fi

        sleep $SLEEP_SECONDS
    done
done

clean_tmp_files

echo "========================================="
echo "middleware $SAMPLE_NAME $result"
echo "========================================="
