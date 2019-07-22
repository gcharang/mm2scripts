#!/bin/bash
source userpass
curl -s --url "http://127.0.0.1:7783" --data "{\"userpass\":\"$userpass\",\"method\":\"electrum\",\"coin\":\"LTC\",\"servers\":[{\"url\":\"electrum-ltc.bysh.me:50001\"},{\"url\":\"electrum.ltc.xurious.com:50001\"}]}"
