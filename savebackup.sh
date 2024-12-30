#!/bin/bash

docker cp -L arma:/home/user/save ./save_$(date +%Y%m%d_%H%M%S)
