#!/bin/sh

if [ -z $1 ]; then
echo 'need backup time in format YYYYmmdd_HHMMSS'
else
docker cp -L "./save_$1/." arma:/home/user/save/
docker exec -t --user root arma chown -R user:user save/
fi
