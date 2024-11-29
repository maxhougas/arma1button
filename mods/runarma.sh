#!/bin/bash
cd /root/Steam/steamapps/common/Arma\ 3\ Server
./arma3server_x64 -config=mods/server.cfg -mod=$(cat mods/modline) > mods/arma.log
