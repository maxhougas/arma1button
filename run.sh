#!/bin/bash

docker run -dp 2302-2306:2302-2306/udp -v $(pwd)/107410:$(cat pathmod) -v $(pwd)/mods:/root/Steam/steamapps/common/Arma\ 3\ Server/mods --name arma-s arma-i
