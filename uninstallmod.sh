#!/bin/bash

arma=$(cat patharma)
mod=$(cat pathmod)
dexec="docker exec -t arma"
workshop=$(cat workshop)

#remove record from appworkshop
installed=$($dexec sed -z 's:\n:!!:g' $workshop | grep -Po $1.*?size.*?} | sed 's:":\\":g')
details=$($dexec sed -z 's:\n:!!:g' $workshop | grep -o Details.*$ | grep -Po $1.*?timetouched.*?} | sed 's:":\\":g')
$dexec sed -zi 's:\n:!!:g' $workshop
$dexec sed -i "s:\"$installed::" $workshop
$dexec sed -i "s:\"$details::" $workshop
$dexec sed -i "s:!!:\n:g" $workshop

#remove data
$dexec rm -rf "$mod/$1"

#remove link
name=$(grep $1 missionlist | grep -Po "(?<==)[a-zA-Z0-9._-]*")
$dexec rm -f "$arma/mpmissions/$name.pbo"

name=$(grep $1 modlist | grep -Po "(?<==)[a-zA-Z0-9._-]*")
$dexec rm -f "$arma/mods/lns/$name"
$dexec sed -i "s:;mods/lns/$name::g" "$arma/mods/modline"
