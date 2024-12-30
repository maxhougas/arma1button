#!/bin/bash

docker run -d \
 -p 2302-2306:2302-2306/udp \
 --name arma maxhougas/arma3temp:bb \
 tail -f /dev/null
