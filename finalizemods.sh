#!/bin/bash

arma=$(cat patharma)
dexec='docker exec -t arma'

#iterate modlist
for line in $(cat modlist)
do

id=$(echo $line | grep -Po "[0-9]*(?==)")
mname=$(echo $line | grep -Po "(?<==)[A-Za-z0-9._-]*")

./linkmod.sh $id $mname
./linkkey.sh $id

done

#Build modline
echo -n $(sed -z 's:\n:;:g' dlclist | sed 's:^:\":') > modline
echo -n $(grep -Po '(?<==)[a-zA-Z0-9._-]*' modlist | sed 's:^:mods/lns/:g' | sed -z 's:\n:;:g' | sed 's:;$:":') >> modline
docker cp modline arma:"$arma/mods/modline"
