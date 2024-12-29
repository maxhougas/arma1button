#!/bin/bash

#Discharge dockerfile
echo 'FROM maxhougas/arma3temp:bb' > dockerfile.ar
echo "RUN su -c 'steamcmd/steamcmd.sh +force_install_dir ~/arma +login $(cat creds) +app_update 233780﻿ -beta creatordlc +quit' user" >> dockerfile.ar
echo 'RUN echo "arma built from maxhougas/arma3temp:bb on $(date +%Y%m%d)" >> /info.txt' >> dockerfile.ar
echo 'USER user:user' >> dockerfile.ar
echo 'CMD tail -f /dev/null' >> dockerfile.ar

#build image
docker build -t arma -f dockerfile.ar .

#Obliterate credentials
rm dockerfile.ar
