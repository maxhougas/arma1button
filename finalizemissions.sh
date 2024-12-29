#!/bin/bash

dexec='docker exec -t arma'

for id in $(cat listmissions | grep -o '^[0-9]*'); do
uid=$($dexec ls /home/user/Steam/userdata | grep -o '[0-9]*')
ugc=$($dexec ls arma/ws/$id | grep -o '[0-9]*')
file=$( \
 $dexec ls -1 /home/user/Steam/userdata/$uid/ugc/referenced/$ugc |\
 grep -o ".*\.pbo" |\
 sed "s:^['\"]::" \
)
$dexec ln -sf "/home/user/Steam/userdata/$uid/ugc/referenced/$ugc/$file" arma/mpmissions
done
