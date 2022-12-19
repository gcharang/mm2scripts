#!/bin/bash
source userpass

# Simplified table view of my orders
# ----------------------------------
# - no param provided
# - first param provided
# - first and second param provided

MY_ORDERS=$(curl -Ss --url "http://127.0.0.1:7783" --data "{\"userpass\":\"$userpass\",\"method\":\"my_orders\"}");

printf "%s\n";
printf "%sUUID                                    Base    Rel     Price   Volume    \n";
printf "%s--------------------------------------------------------------------------\n";

# var1 unset = no params provided -> list all records
if [ -z "$1" ]; then

  printf $MY_ORDERS | jq ".result.maker_orders | [map(.) | .[] | {uuid: .uuid, base: .base, rel: .rel, price: .price|tonumber, amount: .available_amount|tonumber}] | sort_by(.price) | sort_by(.rel) | sort_by(.base)" | jq -r '.[]|flatten|@tsv';
  printf "%s\n";
  exit 0;
fi

# var2 unset = one param provided -> list var1 found in records
if [ -z "$2" ]; then

  printf $MY_ORDERS | jq ".result.maker_orders | [map(.) | .[] | {uuid: .uuid, base: .base, rel: .rel, price: .price|tonumber, amount: .available_amount|tonumber}] | sort_by(.price) | sort_by(.rel) | sort_by(.base) | .[] | select(.base==\"$1\" or .rel==\"$1\")" | jq -r 'flatten|@tsv'; 
  printf "%s\n";

# var2 set = two params provided -> list var1/var2 pair records
else 

  printf $MY_ORDERS | jq ".result.maker_orders | [map(.) | .[] | {uuid: .uuid, base: .base, rel: .rel, price: .price|tonumber, amount: .available_amount|tonumber}] | sort_by(.price) | sort_by(.rel) | sort_by(.base) | .[] | select(.base==\"$1\" and .rel==\"$2\")" | jq -r 'flatten|@tsv'; 
  printf "%s\n";

fi


