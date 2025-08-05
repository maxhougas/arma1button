#!/bin/sh

docker create \
 -p 0.0.0.0:2302-2306:2302-2306/udp \
 -w /home/user/arma \
 --name arma arma3:${1:-dlc} \
 sh -c "chown -LR user:user /home/user/save && su -c './arma3server_x64 -par=/home/user/params' user"
