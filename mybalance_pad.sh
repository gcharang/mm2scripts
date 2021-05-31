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

BALANCES=$(jq -r '

  def width:      map( . | map(length) | max) | max ;
  def pad($w):    . + (($w-length)*" ") ; 
  def padnum($w): ( . |tonumber as $b | $b|floor as $n | ($b - $n) as $f | if $f == 0 then "0.0" else $f end | . as $f | (20 - ($f|tostring|length|tonumber)) as $l | ($f|tostring + ($l*"0")) | ltrimstr("0") as $f | (10 - ($n|tostring|length|tonumber)) as $l | (($l*" ") + ($n|tostring)) as $n | ($n + $f) |  . ) ; 

  [.result | .[] | .mybalance] 
  | . as $mb | 
    ([
      ( [ $mb | .[] | {"address"}] | width as $w | map({ address: .address|pad($w) }) ),
      ( [ $mb | .[] | {"coin"}]    | width as $w | map({ coin:    .coin|pad($w)    }) ),
      ( [ $mb | .[] | {"balance"}] | width as $w | map({ balance: .balance|padnum($w) }) ),
      ( [ $mb | .[] | {"unspendable_balance"}] | width as $w | map({ unspendable_balance: .unspendable_balance|pad($w) }) )
    ]) 
  | [transpose | .[] | add] | sort_by(.coin) | .[] | flatten | @tsv

' <<< "$ENABLED_COINS"); 

printf "\n";
printf   "Address                                 Coin               Balance            Unspendable\n";
printf "%s-----------------------------------------------------------------------------------------\n";
printf "$BALANCES";
printf "\n";
printf "\n";
 
