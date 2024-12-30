#!/bin/bash

docker exec -t arma steamcmd/steamcmd.sh +force_install_dir /home/user/arma +login $(cat creds) +app_update 233780 -beta creatordlc +quit
