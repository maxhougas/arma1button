#!/bin/bash

arma=$(cat patharma)

#Discharge dockerfile
echo "FROM maxhougas/steambox:db" > dockerfile.db
echo "RUN ./steamcmd.sh +set_steam_guard_code $(cat steamguard) +login $(cat creds) +app_update 233780﻿ -beta creatordlc +quit" >> dockerfile.db
echo "WORKDIR '$arma/'" >> dockerfile.db
echo "RUN mkdir -p mods/lns" >> dockerfile.db
echo "RUN mkdir -p /root/Steam/steamapps/workshop/" >> dockerfile.db
echo "RUN mkdir -p /root/.local/share/'Arma 3 - Other Profiles'/Player" >> dockerfile.db
echo "COPY server.cfg mods/server.cfg" >> dockerfile.db
echo "CMD tail -f /dev/null" >> dockerfile.db

#build image
docker build -t arma -f dockerfile.db .

#Obliterate credentials
rm dockerfile.db
