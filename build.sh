#!/bin/bash

docker pull maxhougas/steambox:db
docker build -t arma -f dockerfile.db .
