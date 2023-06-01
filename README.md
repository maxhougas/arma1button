# GUESS WHAT! THIS PROJECT IS COMPLETELY UNTESTED!
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

## Files
- _AACREATEARMA.sh: Entrypoint.
- build.sh: invokes docker build. Will attempt to build arma-i using maxhougas/steambox-i:db.
- cheapinstall.sh installs and links mods and missions. Does the jobs of installmods.sh, installmissions.sh, linkmod.sh, and linkkey.sh.
- creds: contains your actual Steam credentials in plaintext. Super-duper secure, never blind or delete this file. Not included.
- dexec.sh: invokes docker exec. Can only take a single argument.
- dockerfile.db: used when invoking docker build (build.sh). Will contain plaintext credentials. Discharged and deleted after use by prepfolder.sh
- installmod.sh: invokes docker exec > steamcmd.sh. Useful for mods that DLs that time out. Does not link anything.
- linkkey.sh: invoked by cheapinstall.sh. Creates softlinks.
- linkmod.sh: invoked by cheapinstall.sh. Creates softlinks.
- missionlist: contains idnumbers and mission names. Mission names *MUST* end with .[mapcode].
- modlist: contains idnumbers and modnames. Mod names are arbitrary, but this system assumes names contain only [0-9A-Za-z._-]*.
- patharma: contains the full path to .../Arma\ 3\ Server, it is rendered as /Arma 3 Server though, be careful with that.
- pathmod: contains the full path to .../107410.
- prepfolder.sh: poorly named, creates .../mods and .../mods/lns; copies runarma.sh and server.cfg to .../mods; discharges dockerfile.db.
- README.MD: this.
- restart.sh: invokes docker stop and docker start.
- run.sh: invokes docker run. Will attempt to run arma-s. Incoming ports are specified here. Bind mounts are specified here.
- server.cfg: config file. Not included.
- start.sh: invokes docker stop.
- steamguard: contains your steamguard code.
- steaminst: a steam CMD script file. Will contain plaintext credentials. Dischaged and deleted after use by cheapinstall.sh. Not included.
- stop.sh: invokes docker start.
### Depricated
- installmods.sh: invokes docker exec > steamcmd.sh to download mods. Creates appropriate softlinks and discharges the modline file.
- installmissions.sh: invokes docker exec > steamcmd.sh to download missions. Creates softlinks.
