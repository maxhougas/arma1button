#!/bin/bash

#$1 = id

dexec='docker exec -t arma'

#normalize addons folder
addonsf=$($dexec ls arma/ws/$1 | grep -io addons)
if [ $addonsf != addons ]; then
$dexec mv arma/ws/$1/$addonsf arma/ws/$1/addons
fi

for pname in $($dexec ls arma/ws/$1/addons | grep -io "[a-zA-Z0-9%._-]*")
do

#normalize pbo names
npname=$(echo $pname | tr [A-Z] [a-z])
if [ $npname != $pname ]; then
$dexec mv arma/ws/$1/addons/$pname arma/ws/$1/addons/$npname
fi

done
