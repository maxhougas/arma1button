#!/bin/bash

mod=107410

for id in $(sed 's:=[A-Za-z0-9._-]*$::g' modlist)
do

 #normalize addons folder
 if [ -n "$(ls $mod/$id | grep -o 'Addons')" ]; then
  mv $mod/$id/Addons $mod/$id/addons
 fi

 #normalize keys folder
 if [ -n "$(ls $mod/$id | grep -o 'Keys')" ]; then
  mv $mod/$id/Keys $mod/$id/keys
 fi

 #normalize pbo names
 for pname in $(ls $mod/$id/addons | grep -io "[A-Z0-9a-z._-]*")
 do
  npname=$(echo $pname | tr [A-Z] [a-z])
  if [ "$pname" != "$npname" ]; then
   mv $mod/$id/addons/$pname $mod/$id/addons/$npname
  fi
 done

 #normalize key names
 if [ -n "$(ls $mod/$1 | grep -io 'keys')" ]; then
  for kname in $(ls $mod/$id/keys | grep -io "[A-Z0-9a-z._-]*.bikey")
  do
   nkname=$(echo $kname | tr [A-Z] [a-z])
   if [ "$kname" != "$nkname" ]; then
    mv $mod/$id/keys/$kname $mod/$id/keys/$nkname
   fi
   ln -sT $mod/$id/keys/$nkname "$arma/keys/$nkname"
  done
 fi

done
