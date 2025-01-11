#!/bin/bash

#$1 = idno

if [ -z $1 ]; then
echo 'Empty?'
exit 1
fi

mod=$(grep $1 listmods)
mission=$(grep $1 listmissions)

if [ -n $mod ] || [ -n $mission ]; then
docker exec -t arma steamcmd/steamcmd.sh +login $(cat creds) +workshop_download_item 107410 $1 -validate +quit
else
echo "Id not found in listmods or listmissions"
fi
