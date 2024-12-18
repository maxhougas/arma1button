#!/bin/bash

mod=$(cat pathmod)
arma=$(cat patharma)
dexec='docker exec -t arma'

found=$($dexec ls $mod | grep -o [0-9]* | sed -z 's:\n:|:g' | sed 's:|$::g')
grep -Ev "$found" listmods > missingmods
grep -Ev "$found" listmissions > missingmissions
