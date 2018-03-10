#!/bin/bash

set -e

function main () {
    pushd $CHROMIUM_PROJECT_DIR/src
    ./out/Default/quic_client --host=127.0.0.1 --port=6121 https://www.example.org/index.html
    popd
}

main "$@"
