#!/bin/bash

arma=$(cat patharma)
mod=$(cat pathmod)
dexec='docker exec -t arma'

#iterate listmissions
for line in $(cat listmissions)
do

id=$(echo $line | grep -Po "[0-9]*(?==)")
mapname=$(echo $line | grep -Po '(?<=\.)[a-zA-Z0-9_-]*$')
file=$($dexec ls $mod/$id | grep -o "[a-zA-Z0-9._-]*_legacy.bin")
missionname=$($dexec grep -Pao '(?<=sourceName.)[ ="]*[a-zA-Z0-9%_-]*' $mod/$id/$file | grep -o '[a-zA-Z0-9%_-]*' | tr [A-Z] [a-z])

if [ -z $missionname ]; then
missionname=$(echo $line | grep -Po '(?<==)[a-zA-Z0-9_-]*')
fi

$dexec ln -sfT $mod/$id/$file "$arma/mpmissions/$missionname.$mapname.pbo"

done
