#!/bin/bash

dexec="docker exec -t arma"

steaminst=$(grep -o '^[0-9]*' dlsmissing |\
 sed -z "\
  s:\n\$:!!:; \
  s:\n:!!workshop_download_item 107410 :g; \
  s:^:workshop_download_item 107410 :; \
  s:^:login $(cat creds)!!:; \
  s:\$:quit:
")

$dexec bash -c "echo $steaminst | sed 's:!!:\n:g' > steaminst"
$dexec steamcmd/steamcmd.sh +runscript /home/user/steaminst
$dexec rm steaminst
