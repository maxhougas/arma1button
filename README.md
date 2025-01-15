# Massive rewrite in progress. Tested successfully one (1) time! Documentation to follow
# ArmA1button
1 button (almost) build, deploy ArmA 3 server with mods

## The bullshit
- Get docker.io
- Create file creds with your steam credentials and current steamguard code.
```
echo -n "[steamuid] [steampasswd] [steamguardcode]" > creds
```
- Create files listmods and listmissions as per the following section, Mods. Examples included.
- Edit file config as per https://community.bistudio.com/wiki/Arma_3:_Server_Config_File. Example is included.
- When ./build.sh is invoked by _AACREATEARMA.sh, Steam should reject your Steamguard code.
- Immediately check your email and update the creds file.
- Run it from the top again. If you're fast enough it should accept the code.
- Working directory is arma:/home/user/.
- ArmA binaries can be updated by invoking armaupdate.sh.

## Mods
- DO NOT invoke dlsinstall.sh and dlsuninstall.sh. They are unfinished and are likely to behave in unexpected ways.
- The listmods and listmissions files are both of the following format
```
[IDNUMBER]=[ARBITRARYNAME]
```
- Mods can be named anything limited by the character set [A-Za-z0-9%._-].
- Missions and mods are downloaded in the usual manner by invoking dlsvalidate.sh or dlsupdateall.sh then reinstall.sh. Successful downloads end up in /home/user/Steam ... somewhere.
- reinstall.sh will discharge steaminst to arma:.../user/, invoke steamcmd, and delete arma:.../user/steaminst.
- If the addons and keys folders' names are unnormalized, they are normalized by finalisemods.sh -> linkmod.sh.
- Individual file names in arma:.../addons are normalized. Soft linkds are created in arma:.../arma/keys.
- The modline is inserted into arma:.../user/params possibly clobbering a previous modline.
- Missions and mods can be updated by invoking dlsupdateall.sh then dlsreinstall.sh

## Files
- _AACREATEARMA.sh: Entrypoint. Will fail once if your steam account uses steamguard.
- armarun.sh: invokes docker exec to run arma:.../entrypoint.sh -> arma:.../arma/arma3server_x64.
- armaupdate.sh: attempts to update arma3 package.
- build.sh: invokes docker build. Will attempt to build arma using maxhougas/arma.bb.
- config: What they usually call server.cfg. Example included. See https://community.bistudio.com/wiki/Arma_3:_Server_Config_File
- creds: contains your actual Steam credentials in plaintext. Super-duper secure, never blind or delete this file. Not included.
- dexec.sh: invokes docker exec. Can only take a single argument.
- dlsmissing: contains missing mods and missions for use by dlsreinstall.sh
- dlsreinstall.sh: Attempts to install incomplete or missing mods and missions from dlsmissiong.
- dlsupdateall.sh: copies listmissions and listmods to dlsmissiong.
- dlsvalidate.sh: discharges dlsmissing for use by reinstall.sh. Might not work if no mods are installed.
- dockerfile.ar: used when invoking docker build (build.sh). Will contain plaintext credentials. Discharged and deleted after use by build.sh.
- finalizemissions.sh: creates softlinks from arma:.../mpmissions to arma:.../ugc/referenced.....
- finalizemods.sh iterates listmods, and invokes linkkey.sh and linkmod.sh.
- linkkey.sh: invoked by finalizemods.sh. Creates softlinks. Normalizes filenames.
- linkmod.sh: invoked by finalizemods.sh. Normalizes filenames.
- listdlc: contains codes for CDLC to be used.
- listmissions: contains idnumbers and mission names.
- listmods: contains idnumbers and modnames. Mod names are arbitrary, but can only use characters froom the set [A-Za-z0-9%._-].
- params: command line parameters for arma3server_x64. 
- README.MD: this.
- restart.sh: invokes docker stop and docker start.
- run.sh: invokes docker run. Incoming ports are specified here.
- savebackup.sh: invokes docker cp to back up arma:.../Player to the host system.
- saverestore.sh: invokes docker cp to restore ./Player_<TIMESTAMP> into amra:.../Player.
- steaminst: a steam CMD script file. Will contain plaintext credentials. Dischaged and deleted after use by reinstall.sh. Not included.

### Depricated
- arma.log: captures stdout and stderr from armarun.sh.
- cheapinstall.sh installs and links mods and missions. Does the jobs of installmods.sh, installmissions.sh, linkmod.sh, and linkkey.sh.
- dlsinstall.sh: DO NOT INVOKE.
- dlsuninstall.sh: DO NOT INVOKE.
- dlswipeall.sh: DO NOT INVOKE. Rebuild the continer from image if necessary.
- installmod.sh: invokes docker exec > steamcmd.sh. Useful for mods that DLs that time out. Does not link anything.
- installmods.sh: invokes docker exec > steamcmd.sh to download mods. Creates appropriate softlinks and discharges the modline file.
- installmissions.sh: invokes docker exec > steamcmd.sh to download missions. Creates softlinks.
- normalize.sh: iterates though modlist and normalizes folder and file names in ./107410/
- patharma: contains the full path to .../Arma\ 3\ Server/, it is rendered as /Arma 3 Server though, be careful with that.
- pathmanifest: contains the full path to the steamcmd workshop manifest file.
- pathmod: contains the full path to .../107410./
- pathsave: contains the full path to .../Player/ where persistent saves are stored. Supersedes the bind mount system.
- prepfolder.sh: poorly named, creates .../mods and .../mods/lns; copies runarma.sh and server.cfg to .../mods; discharges dockerfile.db.
- /save/ This is supposed to be where ArmA stores persistent saves. Useful for Antistasi. No longer used.
- start.sh: invokes docker stop.
- stop.sh: invokes docker stop.
