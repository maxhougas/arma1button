#!/bin/bash

#$1 = id

mod=$(cat pathmod)
arma=$(cat patharma)
dexec='docker exec -t arma'

#normalize keys folder
keysf=$($dexec ls $mod/$1 | grep -io keys*)
if [ -n $keysf ] && [ $keysf != 'keys' ]; then
$dexec mv $mod/$1/$keysf $mod/$1/keys
fi

if [ -n $keysf ]; then

for kname in $($dexec ls $mod/$1/keys | grep -o "[a-zA-Z0-9._-]*.bikey")
do

#normalize key names
nkname=$(echo $kname | tr [A-Z] [a-z])
if [ "$kname" != "$nkname" ]; then
$dexec mv $mod/$1/keys/$kname $mod/$1/keys/$nkname
fi

$dexec ln -sfT $mod/$1/keys/$nkname "$arma/keys/$nkname"

done

fi
