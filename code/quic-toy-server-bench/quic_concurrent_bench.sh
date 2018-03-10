#!/bin/bash

set -e

function main () {
    local NUMBER_OF_CONCURRENT_REQUEST="$1"
    seq $NUMBER_OF_CONCURRENT_REQUEST | parallel -n0 ./quic_request.sh $CHORMIUM_PROJECT_DIR
}

main "$@"
