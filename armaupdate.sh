#!/bin/bash

docker exec -t arma steamcmd/steamcmd.sh +login $(cat creds) +app_update 233780 -beta creatordlc +quit
