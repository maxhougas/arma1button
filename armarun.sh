#!/bin/bash

docker exec -d ./arma3server_x64 -config=mods/server.cfg -mod=$(cat mods/modline) > mods/arma.log
