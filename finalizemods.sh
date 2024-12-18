#!/bin/bash

arma=$(cat patharma)
dexec='docker exec -t arma'

#iterate listmods
for line in $(cat listmods)
do

id=$(echo $line | grep -Po "[0-9]*(?==)")
mname=$(echo $line | grep -Po "(?<==)[A-Za-z0-9._-]*")

./linkmod.sh $id $mname
./linkkey.sh $id

done

#Build modline
sed -z 's:\n:;:g' listdlc | sed 's:^:\":' > modline
grep -Po '(?<==)[a-zA-Z0-9._-]*' listmods | sed 's:^:mods/lns/:g' | sed -z 's:\n:;:g' | sed 's:;$:":' >> modline
