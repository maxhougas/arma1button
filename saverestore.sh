#!/bin/bash

if [ -z $1 ]; then
echo 'need backup time in format YYYYmmdd_HHMMSS'
else
docker cp -L "./Player_$1/." arma:/home/user/save
fi
