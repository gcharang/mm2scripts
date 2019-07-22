#!/bin/bash
source userpass
curl --url "http://127.0.0.1:7783" --data "{\"method\":\"send_raw_transaction\",\"coin\":\"$1\",\"tx_hex\":\"$2\",\"userpass\":\"$userpass\"}"

