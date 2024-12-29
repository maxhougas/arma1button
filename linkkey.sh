#!/bin/bash

#$1 = id
dexec='docker exec -t arma'

keysf=$($dexec ls arma/ws/$1 | grep -io keys*)
if [ -n $keysf ]; then

#normalize keys folder
if [ $keysf != keys ];then
$dexec mv -f arma/ws/$1/$keysf arma/ws/$1/keys
fi

for kname in $($dexec ls arma/ws/$1/keys | grep -o '[a-zA-Z0-9%._-]*.bikey')
do

#normalize key names
nkname=$(echo $kname | tr [A-Z] [a-z])
if [ $kname != $nkname ]; then
$dexec mv -n arma/ws/$1/keys/$kname arma/ws/$1/keys/$nkname
fi

$dexec ln -sf arma/ws/$1/keys/$nkname "arma/keys/$nkname"

done
fi
