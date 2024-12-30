#!/bin/bash

dexec='docker exec -t arma'

#iterate listmods
for id in $(cat listmods | grep -o '^[0-9]*'); do

#normalize addons folder
addonsf=$($dexec ls arma/mods/$id | grep -io addons)
if [ $addonsf != addons ]; then
$dexec mv arma/mods/$id/$addonsf arma/mods/$id/addons
fi

#normalize pbo names
for pname in $($dexec ls arma/mods/$id/addons | grep -io "[a-zA-Z0-9%._-]*"); do
$dexec mv -n arma/mods/$id/addons/$pname arma/mods/$id/addons/$(echo $pname | tr [A-Z] [a-z])
done

#link keys if any
keysf=$($dexec ls arma/mods/$id | grep -io keys* | head -n 1)
if [ -n $keysf ]; then
for kname in $($dexec ls arma/mods/$id/$keysf | grep -o '[a-zA-Z0-9%._-]*.bikey'); do
$dexec ln -sf /home/user/arma/mods/$id/$keysf/$kname "arma/keys/$kname"
done
fi

done

#Build modline
ml=$(sed -z 's:\n:;:g; s:^:-mod=:' listdlc)
ml=$ml$(grep -o '^[0-9]*' listmods | sed -z 's:^:mods/:; s:\n:;mods/:g; s:;mods/$::')
$dexec sed -i "s:^-mod=.*:$ml:" params
