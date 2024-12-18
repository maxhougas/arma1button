#!/bin/bash

arma=$(cat patharma)
mod=$(cat pathmod)
dexec="docker exec -t arma"
workshop=$(cat workshop)

#remove appworkshop records
$dexec sed -zi 's:lled\".*:lled\"\n\t{\n\t}\n\t\"WorkshopItemDetails"\n\t{\n\t}:g' $workshop

#delete modlinks
fnames=$($dexec ls "$arma/mods/lns" | grep -o '[a-zA-Z0-9._-]*' | sed "s:^:mods/lns/:g" | sed -z 's:\n: :g')
$dexec rm -f $fnames

#delete missionlinks
fnames=$($dexec ls "$arma/mpmissions" | grep -o '[a-zA-Z0-9._-]*' | sed "s:^:/mpmissions/:g" | sed -z 's:\n: :g')
$dexec rm -f $fnames

#scrub modline
$dexec sed -i 's:;mods/.*$:":' "mods/modline"

#delete moddata
fnames=$($dexec ls "$mod" | grep -o '[0-9]*' | sed "s:^:$mod/:g" | sed -z 's:\n: :g')
$dexec rm -rf $fnames
