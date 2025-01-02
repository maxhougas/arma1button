#!/bin/bash

dexec='docker exec -t arma'

#find where the .pbos hide
dir=$($dexec find /home/user/Steam/userdata -name '*pbo' | head -n 1 | grep -Po ".*(?=/[0-9]*/[A-Za-z0-9%'._-]*.pbo)")

#link .pbos
for ugc in $($dexec ls $dir | grep -o '[0-9]*'); do
file=$($dexec grep filename $dir/$ugc/data.vdf | grep -o '[^"]*pbo')
$dexec ln -sf "$dir/$ugc/$file" arma/mpmissions/$file
done
