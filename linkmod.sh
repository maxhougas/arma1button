#!/bin/bash

#$1 = id
#$2 = name

mod=$(cat pathmod)
arma=$(cat patharma)
dexec='docker exec -t arma'

#normalize addons folder
addonsf=$($dexec ls $mod/$1 | grep -io addons)
if [ -n $addonsf ] && [ $addonsf != addons ]; then
$dexec mv $mod/$1/$addonsf $mod/$1/addons
fi

#normalize pbo names
for pname in $($dexec ls $mod/$1/addons | grep -io "[a-zA-Z0-9._-]*")
do

npname=$(echo $pname | tr [A-Z] [a-z])
if [ "$pname" != "$npname" ]; then
$dexec mv $mod/$1/addons/$pname $mod/$1/addons/$npname
fi

done

#link
$dexec ln -sfT $mod/$1 "$arma/mods/lns/$2"
