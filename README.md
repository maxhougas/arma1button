# Massive rewrite in progress. Tested successfully one (1) time! Documentation to follow
# ArmA1button
1 button (almost) build, deploy ArmA 3 server with mods

## The bullshit
- Get docker.io
- Create files creds and steamguard with your steam credentials and current steamguard code.
- Create files listmods and listmissions as per the following section MODS. Examples included.
- Create file server.cfg as per https://community.bistudio.com/wiki/Arma_3:_Server_Config_File. Example is included.
```
echo -n "[steamuid] [steampasswd]" > creds
echo -n "[steamguardcode]" > steamguard
```
- When ./build.sh is invoked by _AACREATEARMA.sh, Steam should reject your Steamguard code.
- Immediately check your email and update the steamguard file.
- Run it from the top again. If you're fast enough it should accept the code.
- Working directory is arma:.../Arma\ 3\ Server; however, most action takes place in arma:.../Arma\ 3\ Server/mods.
- ArmA binaries can be updated by invoking updatearma.sh.

## Mods
- The listmods and listmissions files are both of the following format
```
[IDNUMBER]=[ARBITRARYNAME]
```
- Mods can be named anything; mission names MUST end with .[mapcode].
- Missions and mods are downloaded in the usual manner by invoking validatedl.sh then reinstall.sh. Successful downloads end up in arma:...content/107410
- reinstall.sh will discharge steaminst, copy it to arma:.../mods, delete ./steaminst, invoke steamcmd, and delete arma:.../mods/steaminst.
- If the addons and keys folders' names are unnormalized, they are normalized.
- Individual file names in arma:.../addons are normalized. Soft links are created in arma:.../Arma\ 3\ Server/keys and arma:.../Arma\ 3\ Server/mods/lns
- The file modline is discharged to arma:.../Arma\ 3\ Server/mods
- Missions and mods can be updated by invoking updateall.sh then reinstall.sh

## Folder Structure
- /save/ This is supposed to be where ArmA stores persistent saves. Useful for Antistasi.

## Files
- _AACREATEARMA.sh: Entrypoint.
- armarun.sh: invokes docker exec to run the arma3server_x64 binary.
- armaupdate.sh: attempts to update arma3 package.
- build.sh: invokes docker build. Will attempt to build arma using maxhougas/steambox:db.
- creds: contains your actual Steam credentials in plaintext. Super-duper secure, never blind or delete this file. Not included.
- dexec.sh: invokes docker exec. Can only take a single argument.
- dlsreinstall.sh: Attempts to install incomplete or missing mods and missions from missingmods and missingmissions.
- dlsuninstall.sh: uninstalls a single mod. Deletes data and links. Scrubs the app manifest and modline. This requires the appropriate line to be present in listmods or listmissions.
- dlsupdateall.sh: copies listmissions and listmods to missing missions and missingmods.
- dlsvalidate.sh: discharges missingmissions and missingmods for use by reinstall.sh. Does not work if no mods are installed.
- dlswipeall.sh: uninstalls all mods. Deletes data and links. Scrubs the app manifest and modline.
- dockerfile.db: used when invoking docker build (build.sh). Will contain plaintext credentials. Discharged and deleted after use by build.sh.
- finalizemissions.sh: creates softlinks from arma:.../mpmissions to arma:.../107410....
- finalizemods.sh iterates listmods, and invokes linkkey.sh and linkmod.sh.
- linkkey.sh: invoked by finalizemods.sh. Creates softlinks. Normalizes filenames.
- linkmod.sh: invoked by finalizemods.sh. Creates softlinks. Normalizes filenames.
- listmissions: contains idnumbers and mission names. Mission names *MUST* end with .[mapcode].
- listmods: contains idnumbers and modnames. Mod names are arbitrary, but this system assumes names contain only [0-9A-Za-z._-]*.
- missingmissions: discharged by validatedl.sh. Contains missing or incomplete missions.
- missingmods: discharged by validatedl.sh. Contains missing or incomplete mods.
- patharma: contains the full path to arma:.../Arma\ 3\ Server, it is rendered as /Arma 3 Server though, be careful with that.
- pathmod: contains the full path to arma:.../107410.
- README.MD: this.
- restart.sh: invokes docker stop and docker start.
- run.sh: invokes docker run. Will attempt to run arma. Incoming ports are specified here. Bind mounts are specified here.
- server.cfg: config file. Example included.
- steamguard: contains your steamguard code.
- steaminst: a steam CMD script file. Will contain plaintext credentials. Dischaged and deleted after use by reinstall.sh. Not included.
- updatearma.sh: invokes arma:/steam/steam.sh to update the ArmA server executable.

### Depricated
- cheapinstall.sh installs and links mods and missions. Does the jobs of installmods.sh, installmissions.sh, linkmod.sh, and linkkey.sh.
- installmod.sh: invokes docker exec > steamcmd.sh. Useful for mods that DLs that time out. Does not link anything.
- installmods.sh: invokes docker exec > steamcmd.sh to download mods. Creates appropriate softlinks and discharges the modline file.
- installmissions.sh: invokes docker exec > steamcmd.sh to download missions. Creates softlinks.
- normalize.sh: iterates though modlist and normalizes folder and file names in ./107410/
- prepfolder.sh: poorly named, creates .../mods and .../mods/lns; copies runarma.sh and server.cfg to .../mods; discharges dockerfile.db.
- start.sh: invokes docker stop.
- stop.sh: invokes docker stop.
