#!/bin/bash

#Prepare folder structure
mkdir mods
mkdir mods/lns
cp server.cfg mods
cp runarma.sh mods

#Pull base image
docker pull maxhougas/steambox:db

#Discharge dockerfile
echo "FROM maxhougas/steambox:db" > dockerfile.db
echo "RUN ./steamcmd.sh +set_steam_guard_code $(cat steamguard) +login $(cat creds) +app_update 233780﻿ -beta creatordlc +quit" >> dockerfile.db
echo "WORKDIR /root/Steam/steamapps/common/Arma\\ 3\\ Server" >> dockerfile.db
echo "CMD ./mods/runarma.sh" >> dockerfile.db

#build image
./build.sh

#Obliterate credentials
rm dockerfile.db
