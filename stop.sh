#!/bin/bash
source userpass
curl -s --url "http://127.0.0.1:7783" --data "{\"method\":\"stop\",\"userpass\":\"$userpass\"}"
