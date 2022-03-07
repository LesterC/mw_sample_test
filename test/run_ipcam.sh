#!/bin/sh

BASEDIR=$(dirname "$0")
source $BASEDIR/../common/pre_check.sh

SAMPLE_NAME=sample_ipcam
OUT_FILE="out.txt"
result="TEST-PASS"
check_ret=0

function verify() {
    grep_result=$(grep "finalized, exit program" $OUT_FILE)

    if [ -z "$grep_result" ]; then
        check_ret=-1
    fi
}

function clean_tmp_files() {
    rm -rf $OUT_FILE
}

env_check
sample_check $SAMPLE_NAME

for i in $(seq 1 $TEST_TIMES)
do
    { sleep 5; killall $SAMPLE_NAME; } &
    $SAMPLE_DIR/$SAMPLE_NAME | tee $OUT_FILE
    verify

    if [ $check_ret != 0 ]; then
        result="TEST-FAIL"
        break
    fi

    sleep $SLEEP_SECONDS
done

clean_tmp_files

echo "========================================="
echo "middleware $SAMPLE_NAME $result"
echo "========================================="
