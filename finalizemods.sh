#!/bin/bash

dexec='docker exec -t arma'

#iterate listmods
for line in $(cat listmods)
do

id=$(echo $line | grep -o "^[0-9]*")

./linkmod.sh $id
./linkkey.sh $id

done

#Build modline
ml=$(sed -z 's:\n:;:g; s:^:-mod=:' listdlc)
ml=$ml$(grep -o '^[0-9]*' listmods | sed -z 's:^:ws/:; s:\n:;ws/:g; s:;ws/$::')
$dexec sed -i "s:^-mod=.*$:$ml:" params
