#!/bin/bash
docker run -dp 2302-2306:2302-2306/udp -v $(pwd)/save:/root/.local/share/Arma\ 3\ -\ Other\ Profiles/Player -v $(pwd)/workshop:/root/Steam/steamapps/workshop -v $(pwd)/mods:/root/Steam/steamapps/common/Arma\ 3\ Server/mods --name arma-s arma-i
