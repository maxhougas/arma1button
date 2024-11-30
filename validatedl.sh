#!/bin/bash

mod=$(cat pathmod)
arma=$(cat patharma)
dexec='docker exec -t arma'

found=$($dexec ls -1 mod | grep [0-9]* | sed -z 's:\n:|:g' | sed 's:^:":' | sed 's:|$:":')
grep -Ev "$found" modlist > missingmods
grep -Ev "$found" missionlist > missingmissions
