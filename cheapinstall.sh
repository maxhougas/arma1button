#!/bin/bash

arma=$(cat patharma)
mods=$(cat pathmod)

echo "set_steam_guard_code $(cat steamguard)" > mods/steaminst
echo "login $(cat creds)" > mods/steaminst
echo "$(cat modlist)" >> mods/steaminst
echo "$(cat missionlist)" >> mods/steaminst
sed -i 's:^:workshop_download_item 107410 :g' mods/steaminst
sed -i 's:^workshop_download_item 107410 set:set:g' mods/steaminst
sed -i 's:^workshop_download_item 107410 login:login:g' mods/steaminst
sed -i 's:=[A-Za-z0-9._-]*::g' mods/steaminst
echo "quit" >> mods/steaminst


docker exec -ti arma /steam/steamcmd.sh +runscript "$arma/mods/steaminst"

#obliterate credentials
rm mods/steaminst

#Start modline
echo -n \" > mods/modline

for line in $(cat dlclist)
do
 echo -n "$line;" >> mods/modline
done

#iterate modlist
for line in $(cat modlist)
do

id=$(echo $line | sed "s:=[A-Za-z0-9._-]*::g")
mname=$(echo $line | sed "s:[0-9]*=::g")

./linkmod.sh $id $mname
./linkkey.sh $id

#Build modline
echo -n "mods/lns/$mname;" >> mods/modline

done

#Finish modline
sed -i "s:;$:\":g" mods/modline

#iterate missionlist
for line in $(cat missionlist)
do

id=$(echo $line | sed "s:=[A-Za-z0-9._-]*::g")
mname=$(echo $line | sed "s:[0-9]*=::g")
file=$(docker exec -t arma ls -1 $mods/$id | grep -io "[a-zA-Z0-9._-]*")


docker exec -t arma ln -sfT $mods/$id/$file "$arma/mpmissions/$mname.pbo"

done
