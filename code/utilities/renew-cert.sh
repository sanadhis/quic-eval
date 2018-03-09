#!/bin/bash

set -e

function generate-cert () {
	local CHROMIUM_DIR="$1"
	pushd $CHROMIUM_DIR/src/net/tools/quic/certs
	./generate-certs.sh
	popd
}

function add-cert () {
	local CHROMIUM_DIR="$1"
	certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n "TestCert" -i $CHROMIUM_DIR/src/net/tools/quic/certs/out/2048-sha256-root.pem
}

function main () {
	generate-cert "$1"
	add-cert "$1"
}

main "$@"
