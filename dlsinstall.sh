#!/bin/bash

#$1 = idno

if [ -z $1 ]; then
echo "empty?"
exit 1
fi

mod=$(grep $1 listmods)
mission=$(grep $1 listmissions)

if [ -n $mod -o -n $mission ]; then

docker exec -ti arma /steam/steamcmd.sh +login $(cat creds) +workshop_download_item 107410 $1 +quit

else

echo "Id not found in listmods or listmissions"

fi
