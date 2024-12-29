#!/bin/bash
docker run -d \
 -p 2302-2306:2302-2306/udp \
 --name arma arma \
 tail -f /dev/null
