#!/bin/bash
stdbuf -oL nohup ./mm2 "{\"gui\":\"MM2GUI\",\"netid\":7777, \"userhome\":\"/${HOME#"/"}\", \"passphrase\":\"REPLACE_TRADING_WALLET_PASSPHRASE\", \"rpc_password\":\"RPC_CONTROL_USERPASSWORD\"}" &
