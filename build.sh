#!/bin/sh

if [ "$1" = 'nomod' ]; then

if [ "$2" = 'base' ]; then
base=''
else
base='-beta creatordlc'
fi

#Discharge dockerfile base game layer 
echo 'FROM maxhougas/arma3:tem' > dockerfile.ar.base
echo "RUN su -c 'steamcmd/steamcmd.sh +force_install_dir ~/arma +login $(cat creds) +app_update 233780 $base +quit' user" >> dockerfile.ar.base
echo 'COPY --chown=user:user server.cfg ./' >> dockerfile.ar.base
echo 'RUN echo "arma3:base built from maxhougas/arma3:tem on $(date +%Y%m%d)" >> /info.txt' >> dockerfile.ar.base

#build image
docker build -t arma3:base -f dockerfile.ar.base .

#Obliterate credentials
rm dockerfile.ar.base

else
#Discharge dockerfile dlc layer
echo 'FROM arma3:base' > dockerfile.ar.dlc
echo 'COPY --chown=user:user ["listdlc","listmissions","listmods","./"]' >> dockerfile.ar.dlc
echo "RUN su -c './dlsupdateall.sh && ./dlsreinstall.sh $(cat creds) && ./finalizemissions.sh && ./finalizemods.sh' user" >> dockerfile.ar.dlc
echo 'RUN echo "arma3:dlc built from arma3:base on $(date +%Y%m%d)" >> /info.txt' >> dockerfile.ar.dlc

#build image
docker build -t arma3:dlc -f dockerfile.ar.dlc .

#Obliterate credentials
rm dockerfile.ar.dlc
fi
