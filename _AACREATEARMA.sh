#!/bin/bash

./run.sh
./armaupdate.sh
./dlsupdateall.sh
./dlsreinstall.sh
./finalizemods.sh
./finalizemissions.sh
docker exec -d arma ./entrypoint.sh
