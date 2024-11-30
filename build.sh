#!/bin/bash

arma=$(cat patharma)

#Discharge dockerfile
echo "FROM maxhougas/steambox:db" > dockerfile.db
echo "RUN ./steamcmd.sh +set_steam_guard_code $(cat steamguard) +login $(cat creds) +app_update 233780﻿ -beta creatordlc +quit" >> dockerfile.db
echo "WORKDIR '$arma/'" >> dockerfile.db
echo "RUN mkdir -p mods/lns" >> dockerfile.db
echo "COPY dlclist mods/dlclist" >> dockerfile.db
echo "COPY server.cfg mods/server.cfg" >> dockerfile.db
echo "COPY runarma.sh mods/runarma.sh" >> dockerfile.db
echo "RUN sed -z 's:\n:;:g' mods/dlclist | sed 's:^:\":' | sed 's:;$:\":' > mods/modline" >> dockerfile.db
echo "CMD ./mods/runarma.sh" >> dockerfile.db

#build image
docker build -t arma -f dockerfile.db .

#Obliterate credentials
rm dockerfile.db
