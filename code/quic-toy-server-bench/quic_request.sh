#!/bin/bash

set -e

function main () {
    local CHROMIUM_PRJ_DIR="$1"
    pushd $CHROMIUM_PRJ_DIR
    ./out/Default/quic_client --host=127.0.0.1 --port=6121 https://www.example.org/index.html
    popd
}

main "$@"
