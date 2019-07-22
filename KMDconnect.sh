#!/bin/bash
source userpass
curl -s --url "http://127.0.0.1:7783" --data "{\"userpass\":\"$userpass\",\"method\":\"electrum\",\"coin\":\"KMD\",\"servers\":[{\"url\":\"electrum1.cipig.net:10001\"},{\"url\":\"electrum2.cipig.net:10001\"}]}"
