#!/bin/bash
pushd tor-build
docker build -t tor .
popd
pushd firefox-build
docker build -t firefox .
popd
docker run -d --rm --net=host --name=tor tor
XAUTH=`xauth list`
docker run -it -e DISPLAY="$DISPLAY" -e XAUTH="$XAUTH" -v /tmp/.X11-unix --net=host --shm-size=4g --name=firefox --rm firefox
docker rm -f tor
