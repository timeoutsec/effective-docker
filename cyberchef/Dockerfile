FROM alpine:latest as build-chef
# update the alpine linux apk index to latest packages
# install nodejs, npm, and git as packages needed for build
RUN apk update && apk add nodejs npm git
# create a cyberchef user
RUN adduser -D cyberchef
# create a build directory with cyberchef user permissions
RUN mkdir -vp /opt/cyberchef && chown -v cyberchef:cyberchef /opt/cyberchef
# set the build user to cyberchef
USER cyberchef
# make and utilize a new working directory for cyberchef
WORKDIR /opt/cyberchef

# install cyberchef
# enable experimental json modules for node, otherwise errors out
ENV NODE_OPTIONS="--experimental-json-modules"
# clone the github to the working directory /opt/cyberchef
RUN git clone --depth=1 https://github.com/gchq/CyberChef.git .
# install, --unsafe-perm is related to issue 1162 in cyberchef
RUN npm install --unsafe-perm
# utilize npx grunt and build a production build -> if you wonder where "prod" comes from, look in Gruntfile.js
RUN npx grunt prod

FROM alpine:latest
RUN apk update
RUN apk add apache2 apache2-ssl
# by default apache2 has a localhost directory, change it to cyberchef and update locations
RUN mv -v /var/www/localhost /var/www/cyberchef
RUN sed -i "s#/var/www/localhost#/var/www/cyberchef#g" /etc/apache2/httpd.conf
RUN sed -i "s#/var/www/localhost#/var/www/cyberchef#g" /etc/apache2/conf.d/ssl.conf
# change around some other things in ssl.conf
RUN sed -i "s#^ServerName.*#ServerName cyberchef:443#g" /etc/apache2/conf.d/ssl.conf

# move the contents to the webserver directory /var/www/cyberchef/htdocs
# fun fact: you can not only copy files from the current working directory
#           but also from other images on your system
COPY --from=build-chef /opt/cyberchef/build/prod /var/www/cyberchef/htdocs

# copy selfsigned cert and key to respective location pointed to by apache
# made by running the command
# openssl req -x509 -nodes -newkey rsa:4096 -out cyberchef.cert -keyout cyberchef.key -subj="/CN=cyberchef"
COPY cyberchef.cert /etc/ssl/apache2/server.pem
COPY cyberchef.key /etc/ssl/apache2/server.key

# set the entrypoint to kickoff the webserver
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
