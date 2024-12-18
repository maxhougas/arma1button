#!/bin/bash

docker exec arma ./arma3server_x64 -config=mods/server.cfg -mod=$(cat ./modline) &> arma.log &
