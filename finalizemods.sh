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
modline1=$(grep -Po '(?<==)[a-zA-Z0-9._-]*' modlist | sed 's:^:mods/lns/:g' | sed -z 's:\n:;:g' | sed 's:;$:":')
$dexec cp mods/dlclist mods/modline
$dexec sed -zi 's:\n:;:g' mods/modline
$dexec sed -i 's:^:\":' mods/modline
$dexec sed -i "s:$:$modline1:" mods/modline
