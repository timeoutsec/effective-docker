#!/bin/bash
# kick off tor container using host driver, uses hosts
# network namespace
docker run -d --rm --net=host --name=tor tor
# populate a valid XAUTH cookie for use inside container
XAUTH=`xauth list`
# run the container, passing necessary X window sytem environ
# and the .X11-unix directory.
# needs to be in host network namespace for X window system
docker run -it -e DISPLAY="$DISPLAY" -e XAUTH="$XAUTH" -v /tmp/.X11-unix --net=host --shm-size=4g --name=firefox --rm firefox
# once the firefox closes, kill the tor container
docker rm -f tor
