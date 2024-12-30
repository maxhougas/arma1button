#!/bin/bash

dexec='docker exec -t arma'

#find where the .pbos hide
id=$(head -n 1 listmissions | grep -o '^[0-9]*')
ugc=$($dexec ls arma/mods/$id | grep -o '[0-9]*')
dir=$($dexec find /home/user -name $ugc | grep -Po ".*(?=/$ugc)")

#link .pbos
for id in $(cat listmissions | grep -o '^[0-9]*'); do
ugc=$($dexec ls arma/mods/$id | grep -o '[0-9]*')
file=$($dexec grep filename $dir/$ugc/data.vdf | grep -o '[^"]*.pbo')
$dexec ln -sf "$dir/$ugc/$file" arma/mpmissions/$file
done
