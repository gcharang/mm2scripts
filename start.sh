#!/bin/bash
stdbuf -oL ./mm2 "{\"gui\":\"MM2GUI\",\"netid\":9999, \"userhome\":\"/${HOME#"/"}\", \"passphrase\":\"REPLACE_TRADING_WALLET_PASSPHRASE\", \"rpc_password\":\"RPC_CONTROL_USERPASSWORD\"}" &
