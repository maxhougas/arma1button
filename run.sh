#!/bin/bash

docker run -d \
 -p 2302:22/tcp \
 -p 2302-2306:2302-2306/udp \
 --name arma arma \
 sh -c 'tail -f /dev/null'

docker exec -d arma .ssh/sshd.sh
