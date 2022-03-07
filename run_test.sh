#!/bin/sh

BASEDIR=$(dirname "$0")
. $BASEDIR/env
source $BASEDIR/common/pre_check.sh

function usage()
{
    echo "$0 [TEST CASE]"
    echo "              all"
    for f in $BASEDIR/test/*.sh;
    do
        echo "              ${f}"
    done
    echo ""
    echo "Mandatory env"
    echo "    SAMPLE_DIR                   - middleware sample binary directory"
    echo ""
    echo "Optional env"
    echo "    TEST_TIMES                   - repeat times for each test case, default 1"
    echo "    SLEEP_SECONDS                - sleep seconds between each test case, default 3"
    echo ""

    exit 1
}

function run_all()
{
    for f in $BASEDIR/test/*.sh;
    do
        echo "=================== run $f ==================="
        $f
        sleep $SLEEP_SECONDS
    done
}

function run_single()
{
    $1
}

env_check

export SAMPLE_DIR TEST_TIMES SLEEP_SECONDS

if [ "$1" == "all" ]; then
    run_all
elif [ -n $1 -a -x "$1" ]; then
    run_single "$1"
else
    usage
fi
