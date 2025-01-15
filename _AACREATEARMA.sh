#!/bin/bash

./build.sh
if [ "$?" -gt '0' ]; then
 echo 'Build failed. Probably steam credentials.'
 echo 'Verify <STEAM_ID> <PASSWD> <STEAM_GUARD_CODE> in ./creds and try again.'
 exit $?
fi
./run.sh
./dlsupdateall.sh
./dlsreinstall.sh
./finalizemods.sh
./finalizemissions.sh
docker exec -d arma ./entrypoint.sh
