#!/bin/bash

#$1 = idno

mod=$(grep $1 modlist)
mission=$(grep $1 missionlist)

if [ -n $mod -o -n $mission ]; then

docker exec -ti arma-s /steam/steamcmd.sh +login $(cat creds) +workshop_download_item 107410 $1 +quit

else

echo "Id not found in modlist or missionlist"

fi
