#!/bin/sh
openssl req -x509 -nodes -newkey rsa:4096 -out cyberchef.cert -keyout cyberchef.key -subj="/CN=cyberchef"
