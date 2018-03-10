#!/bin/bash

set -e

function main () {
    local CHORMIUM_PROJ_DIR="$1"
    local NUMBER_OF_CONCURRENT_REQUEST="$2"
    seq $NUMBER_OF_CONCURRENT_REQUEST | parallel -n0 ./quic_request.sh $CHORMIUM_PROJ_DIR
}

main "$@"
