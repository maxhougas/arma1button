#!/bin/bash

mod=$(cat pathmod)
arma=$(cat patharma)
dexec='docker exec -t arma'

found=$($dexec ls $mod | grep -o [0-9]* | sed -z 's:\n:|:g' | sed 's:|$::g')
grep -Ev "$found" modlist > missingmods
grep -Ev "$found" missionlist > missingmissions
