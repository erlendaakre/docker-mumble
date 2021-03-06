[![](https://images.microbadger.com/badges/version/frostvoid/mumble.svg)](https://microbadger.com/images/frostvoid/mumble "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/frostvoid/mumble.svg)](https://microbadger.com/images/frostvoid/mumble "Get your own image badge on microbadger.com")

## Mumble server (murmur)

Configurable mumble container based off Alpine, installs murmur via apk.
Based on https://hub.docker.com/r/extra/mumble/ (startup script)

### Provisioning script

https://raw.githubusercontent.com/erlendaakre/docker-mumble/master/provision.sh

Edit the 3 top variables in this script, then run it to set up a fully working mumble server
```
SERVERPASS="CHANGEME"
ADMINPASS="CHANGEME"
MOTD="<br/>LINE ONE<br/>LINE TWO"
    
CONTAINERNAME="mumble"
VOLUMENAME="mumble-data"
RESTARTPOLICY="--restart=always"

docker pull frostvoid/mumble
docker volume create $VOLUMENAME
docker run -d -p 64738:64738 -p 64738:64738/udp -v $VOLUMENAME:/data --name=$CONTAINERNAME $RESTARTPOLICY -e "SERVER_PASSWORD=$SERVERPASS" -e "SUPW=$ADMINPASS" -e "SERVER_TEXT=$MOTD" frostvoid/mumble
```

### How to run
This sets up a simple instance with defaults, the easiest way to get a configured mumble up and running however is to use the Provisioning script above

`docker volume create mumble_data`
`docker run -p 64738:64738 -p 64738:64738/udp -d -v mumble_data:/data frostvoid/mumble`


### Environment Variables
You can provide multiple settings using environment variables when creating the container. If you want to make any changes on an existing container replace the /data/murmur.ini file using `docker cp`

`sudo docker run -e "MAX_USERS=50" frostvoid/mumble`

* MAX_USERS : Maximum users connected at the same time
* SERVER_TEXT : Welcome Text
* REGISTER_NAME : Root channel name (default : "Root")
* SERVER_PASSWORD : Server access passord (default : no password required)
* SUPW : SuperUser password  (default : generated, get with `docker logs mumble`)
* BANDWIDTH : connection bandwidth (default : 72000 bps)

### Murmur.ini
The following config file is used as a base

```
host=0.0.0.0
database=/data/db.sqlite
port=64738

autobanAttempts = 10
autobanTimeframe = 120
autobanTime = 600

logfile=/data/murmur.log
logdays=45

allowhtml=false
bonjour=false
sendversion=false
```
