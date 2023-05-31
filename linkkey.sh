#!/bin/bash

#$1 = id

mod=$(cat pathmod)
arma=$(cat patharma)

#normalize keys folder
if [ -n "$(docker exec -t arma-s ls $mod/$1 | grep -o 'Keys')" ]; then

docker exec -t arma-s mv $mod/$1/Keys $mod/$1/keys

fi

if [ -n "$(docker exec -t arma-s ls $mod/$1 | grep -io 'keys')" ]; then

for kname in $(docker exec -t arma-s ls $mod/$1/keys | grep -io "[A-Z0-9a-z._-]*.bikey")
do

#normalize key names
nkname=$(echo $kname | tr [A-Z] [a-z])
if [ "$kname" != "$nkname" ]; then

docker exec -t arma-s  mv $mod/$1/keys/$kname $mod/$1/keys/$nkname

fi

docker exec -t arma-s ln -sT $mod/$1/keys/$nkname "$arma/keys/$nkname"

done

fi
