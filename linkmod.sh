#!/bin/bash

#$1 = id
#$2 = name

mod=$(cat pathmod)
arma=$(cat patharma)

#normalize addons folder
if [ -n "$(docker exec -t arma-s ls $mod/$1 | grep -o 'Addons')" ]; then
docker exec -t arma-s mv $mod/$1/Addons $mod/$1/addons
fi

#normalize pbo names
for pname in $(docker exec -t arma-s ls $mod/$1/addons | grep -io "[A-Z0-9a-z._-]*")
do

npname=$(echo $pname | tr [A-Z] [a-z])
if [ "$pname" != "$npname" ]; then
docker exec -t arma-s  mv $mod/$1/addons/$pname $mod/$1/addons/$npname
fi

done

#link
docker exec -t arma-s ln -sT $mod/$1 "$arma/mods/lns/$2"
