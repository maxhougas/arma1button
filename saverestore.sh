#!/bin/bash

if [ -z $1 ]; then
echo 'need backup time in format YYYYmmdd_HHMMSS'
else
docker cp "./Player_$1/Player.Arma3Profile" arma:"$(cat pathsave)/Player.Arma3Profile"
docker cp "./Player_$1/Player.vars.Arma3Profile" arma:"$(cat pathsave)/Player.vars.Arma3Profile"
fi
