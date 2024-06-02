#!/bin/bash
docker run -dp 2302-2306:2302-2306/udp -v $(pwd)/save:/root/.local/share/Arma\ 3\ -\ Other\ Profiles/Player --name arma arma
