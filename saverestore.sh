#!/bin/bash

if [ -z $1 ]; then
echo 'need backup time in format YYYYmmdd_HHMMSS'
else
docker cp ./Player_$1 arma:"$(cat pathsave)"
fi
