#!/bin/bash

arma=$(cat patharma)
mod=$(cat pathmod)
dexec='docker exec -t arma'

#iterate missionlist
for line in $(cat missionlist)
do

id=$($dexec echo $line | grep -Po "[0-9]*(?==)")
mname=$($dexec echo $line | grep -Po "(?<==)[a-zA-Z0-9._-]*")
file=$($dexec ls -1 $mod/$id | grep -o "[a-zA-Z0-9._-]*")

$dexec ln -sfT $mod/$id/$file "$arma/mpmissions/$mname.pbo"

done
