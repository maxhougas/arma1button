#!/bin/bash

docker cp -L arma:/home/user/save ./Player_$(date +%Y%m%d_%H%M%S)
