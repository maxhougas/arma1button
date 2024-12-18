#!/bin/bash

arma=$(cat patharma)
mods=$(cat pathmod)
dexec="docker exec -t arma"

grep -Po '[0-9]*(?==)' missingmods > steaminst
grep -Po '[0-9]*(?==)' missingmissions >> steaminst
sed -i 's:^:workshop_download_item 107410 :g' steaminst
sed -i "1s:^:login $(cat creds)\n:" steaminst
sed -i "1s:^:set_steam_guard_code $(cat steamguard)\n:" steaminst
echo "quit" >> steaminst

docker cp steaminst arma:"$arma/mods/steaminst"
rm steaminst

$dexec /steam/steamcmd.sh +runscript "$arma/mods/steaminst"
$dexec rm mods/steaminst
