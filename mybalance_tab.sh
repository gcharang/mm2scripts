#!/bin/bash
source userpass
 
# Simplified table view of the enabled coins 
# ---------------------------------------------------

ENABLED_COINS=$(curl -Ss --url "http://127.0.0.1:7783" --data "{\"userpass\":\"$userpass\",\"method\":\"get_enabled_coins\"}");

for k in $(jq '.result | keys | .[]' <<< "$ENABLED_COINS"); do
  
  ticker=$(jq -r ".result[$k] | .ticker" <<< "$ENABLED_COINS");
  mybalance=$(curl -Ss --url "http://127.0.0.1:7783" --data "{\"userpass\":\"$userpass\",\"method\":\"my_balance\",\"coin\":\"$ticker\"}");
  ENABLED_COINS=$(jq -r ".result[$k].mybalance |= . + $mybalance" <<< "$ENABLED_COINS");  
done

ENABLED_COINS=$(jq -r '

  [.result | .[] | .mybalance] 
  | map({address: .address,coin: .coin|tostring, balance: .balance|tonumber})
  | sort_by(.coin) | .[] | flatten | @tsv 

' <<< "$ENABLED_COINS");

printf "\n";
printf "Address                                 Coin    Balance\n";
printf "%s----------------------------------------------------------------------\n";
printf "$ENABLED_COINS";
printf "\n";
printf "\n";
 
