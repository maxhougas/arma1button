# Massive rewrite in progress. Tested successfully one (1) time! Documentation to follow
# ArmA1button
1 button (almost) build, deploy ArmA 3 server with mods

## The bullshit
- Get docker.io
- Create files creds and steamguard with your steam credentials and current steamguard code.
- Create file server.cfg as per https://community.bistudio.com/wiki/Arma_3:_Server_Config_File
```
echo "[steamuid] [steampasswd]" > creds
echo "[steamguardcode]" > steamguard
```
- When ./build.sh is invoked by _AACREATEARMA.sh > prepfolder.sh, Steam should reject your Steamguard code.
- Immediate check your email and update the steamguard file.
- Run it from the top again. If you're fast enough it should accept the old code.

## Mods
- The modlist and missionlist files are both of the following format
```
[IDNUMBER]=[ARBITRARYNAME]
```
- Mods can be named anything; mission names MUST end with .[mapcode].
- Missions are downloaded in the usual manner. Softlinks are created in .../Arma\ 3\ Server/mpmissions.
- Mods are downloaded in the usual manner.
- If the addons and keys folders names are unnormalized, they are normalized.
- Individual file names in .../addons are normalized. Soft links are created in .../Arma\ 3\ Server/keys and .../Arma\ 3\ Server/mods/lns
- The file modline is discharged to .../Arma\ 3\ Server/mods

## Folder Structure
- /save/ This is supposed to be where ArmA stores persistent saves. Useful for Antistasi.

## Files
- _AACREATEARMA.sh: Entrypoint.
- build.sh: invokes docker build. Will attempt to build arma using maxhougas/steambox:db.
- creds: contains your actual Steam credentials in plaintext. Super-duper secure, never blind or delete this file. Not included.
- dexec.sh: invokes docker exec. Can only take a single argument.
- dockerfile.db: used when invoking docker build (build.sh). Will contain plaintext credentials. Discharged and deleted after use by prepfolder.sh
- finalizemissions.sh: creates symlinks from arma:.../mpmissions to arma:.../107410. Normalizes filenames.
- finalizemods.sh invokes linkkey.sh and linkmod.sh. Creates symlinks from :arma.../mods/lns to arma:.../107410. Normalizes filenames.
- installmod.sh: invokes docker exec > steamcmd.sh. Useful for mods that DLs that time out. Does not link anything.
- linkkey.sh: invoked by finalizemods.sh. Creates softlinks.
- linkmod.sh: invoked by finalizemods.sh. Creates softlinks.
- missingmissions: discharged by validatedl.sh. Contains missing or incomplete missions.
- missingmods: discharged by validatedl.sh. Contains missing or incomplete mods.
- missionlist: contains idnumbers and mission names. Mission names *MUST* end with .[mapcode].
- modlist: contains idnumbers and modnames. Mod names are arbitrary, but this system assumes names contain only [0-9A-Za-z._-]*.
- patharma: contains the full path to arma:.../Arma\ 3\ Server, it is rendered as /Arma 3 Server though, be careful with that.
- pathmod: contains the full path to arma:.../107410.
- README.MD: this.
- reinstall.sh: Attempts to install incomplete or missing mods and missions from missingmods and missingmissions.
- restart.sh: invokes docker stop and docker start.
- run.sh: invokes docker run. Will attempt to run arma. Incoming ports are specified here. Bind mounts are specified here.
- server.cfg: config file. Example included.
- steamguard: contains your steamguard code.
- steaminst: a steam CMD script file. Will contain plaintext credentials. Dischaged and deleted after use by reinstall.sh. Not included.
- updateall.sh: copies missionlist and modlist to missing missions and missingmods. reinstall.sh will then attempt to download updates from steam.
- updatearma.sh: invokes arma:/steam/steam.sh to update the ArmA server executable.
- validatedl.sh: discharges missingmissions and missingmods for use by reinstall.sh.

### Depricated
- cheapinstall.sh installs and links mods and missions. Does the jobs of installmods.sh, installmissions.sh, linkmod.sh, and linkkey.sh.
- installmods.sh: invokes docker exec > steamcmd.sh to download mods. Creates appropriate softlinks and discharges the modline file.
- installmissions.sh: invokes docker exec > steamcmd.sh to download missions. Creates softlinks.
- normalize.sh: iterates though modlist and normalizes folder and file names in ./107410/
- prepfolder.sh: poorly named, creates .../mods and .../mods/lns; copies runarma.sh and server.cfg to .../mods; discharges dockerfile.db.
- start.sh: invokes docker stop.
- stop.sh: invokes docker stop.
