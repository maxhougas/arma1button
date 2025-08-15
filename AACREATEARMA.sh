#!/bin/sh

./build.sh nomod nobase 
if [ "$?" -gt '0' ]; then
 echo 'Build failed. Probably steam credentials.'
 echo 'Verify <STEAM_ID> <PASSWD> <STEAM_GUARD_CODE> in ./creds and try again.'
 exit $?
fi
./build.sh mod
if [ "$?" -gt '0' ]; then
 echo 'Build failed. Probably steam credentials.'
 echo 'Verify <STEAM_ID> <PASSWD> <STEAM_GUARD_CODE> in ./creds and try again.'
 exit $?
fi
./create.sh
docker exec -d arma ./entrypoint.sh
