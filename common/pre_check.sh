#!/bin/sh

function env_check() {
    if [ -z ${SAMPLE_DIR} ]; then
        echo "SAMPLE_DIR is not set";
        exit 1
    fi

    if [ ! -d "${SAMPLE_DIR}" ]; then
        echo "SAMPLE_DIR: [$SAMPLE_DIR] is not exist";
        exit 1
    fi
}

function sample_check() {
    sample_bin=${SAMPLE_DIR}/$1

    if [ ! -x ${sample_bin} ]; then
        echo "${sample_bin} is not exist";
        usage
        exit 1
    fi
}