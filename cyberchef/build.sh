#!/bin/bash
# generate necessary self signed certificates
./genkeys.sh
# build the Dockerfile in the current working directory
# to create an image, tag as cyberchef
docker build -t cyberchef .
