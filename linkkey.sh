#!/bin/bash

#$1 = id
dexec='docker exec -t arma'

keysf=$($dexec ls arma/mods/$1 | grep -io keys*)
if [ -n $keysf ]; then

#normalize keys folder
if [ $keysf != keys ];then
$dexec mv -f arma/mods/$1/$keysf arma/mods/$1/keys
fi

for kname in $($dexec ls arma/mods/$1/keys | grep -o '[a-zA-Z0-9%._-]*.bikey')
do

#normalize key names
nkname=$(echo $kname | tr [A-Z] [a-z])
if [ $kname != $nkname ]; then
$dexec mv -n arma/mods/$1/keys/$kname arma/mods/$1/keys/$nkname
fi

$dexec ln -sf arma/mods/$1/keys/$nkname "arma/keys/$nkname"

done
fi
