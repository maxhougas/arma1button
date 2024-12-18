#!/bin/bash

docker exec -ti arma /steam/steamcmd.sh +set_steam_guard_code $(cat steamguard) +login $(cat creds) +app_update 233780 +quit
