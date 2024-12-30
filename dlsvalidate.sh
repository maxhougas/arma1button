#!/bin/bash

dexec='docker exec -t arma'

found=$($dexec ls arma/mods | grep -o '[0-9]*' | sed -z 's:\n:|:g; s:|$::')
grep -Ev "$found" listmissions > dlsmissing
grep -Ev "$found" listmods >> dlsmissing

echo $found

#fallback for nothing found
if [ -z $found ]; then
cp listmissions dlsmissing
cat listmods >> dlsmissing
fi
