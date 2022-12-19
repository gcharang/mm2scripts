#!/bin/bash
source userpass

# Simplified table view of the orderbook 
# ---------------------------------------------------
# Adding trailing zeros to price needs to be improved

ORDERBOOK=$(curl -Ss --url "http://127.0.0.1:7783" --data "{\"userpass\":\"$userpass\",\"method\":\"orderbook\",\"base\":\"$1\",\"rel\":\"$2\"}");

#printf "$ORDERBOOK";

printf "%s\n";
printf "%sAddress                                 Coin    Price           Max. Volume     \n";
printf "%s--------------------------------------------------------------------------------\n";
printf "$ORDERBOOK" | jq ".asks | [map(.) | .[] | {address: .address, coin: .coin, price: (((.price|tonumber + 0.0000000001) * 10000000000)|round | . / 10000000000), maxvol: ((.maxvolume|tonumber * 1000000)|round| . / 1000000)}]" | jq -r '.[]|flatten|@tsv'
printf "%s--------------------------------------------------------------------------------\n";
printf "$ORDERBOOK" | jq ".bids | [map(.) | .[] | {address: .address, coin: .coin, price: (((.price|tonumber + 0.0000000001) * 10000000000)|round | . / 10000000000), maxvol: ((.maxvolume|tonumber * 1000000)|round| . / 1000000)}]" | jq -r '.[]|flatten|@tsv'
printf "%s\n";

