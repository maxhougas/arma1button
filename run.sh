#!/bin/bash
docker run -d \
 -p 2344-2345:2344-2345/tcp \
 -p 27015:27015/tcp \
 -p 27036:27036/tcp \
 -p 2302-2306:2302-2306/udp \
 -p 2344:2344/udp \
 -p 27015:27015/udp \
 -p 27031-27036:27031-27036/udp \
 --name arma arma \
 tail -f /dev/null
