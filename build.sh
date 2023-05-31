#!/bin/bash

docker pull maxhougas/steambox-i:db
docker build -t arma-i -f dockerfile.db .
