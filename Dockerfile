# No thrills Ionic 2 developer environment
# See https://blog.saddey.net/2016/07/03/using-docker-to-create-ionic-2-pwa-developer-environment

FROM ubuntu:16.04

MAINTAINER Reiner Saddey <reiner@saddey.net>

LABEL Description="Interactive Ionic 2 Framework example using volume /projects as the root for your app directories"

RUN apt-get update

RUN apt-get install -y -q \
    curl

# As of 03-jul-16: Ionic is not yet ready for Node.js 6, see https://github.com/driftyco/ionic-cli/issues/960
# RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -
	
# nodejs includes matching npm as well
RUN apt-get install -y -q \
    nodejs \
    && apt-get -y autoclean \
    && rm -rf /var/lib/apt/lists/*

# As of 03-jul-16: You have been warned, DO NOT push this button: RUN npm update -g npm
# https://github.com/npm/npm/issues/9863 Reinstalling npm v3 fails on Docker


# 17-jul-16 global gulp needed for gulp build --typescheck on Ionic framework sources
RUN npm install -g --unsafe-perm -y gulp@3.9.1

RUN npm install -g --unsafe-perm -y ionic@beta

# 19-jul-16 support Angular 2 dev
RUN npm install --unsafe-perm -g -y typescript typings lite-server concurrently angular-cli

COPY readme.txt /readme.txt
COPY start.sh /start.sh

WORKDIR /projects

CMD bash -C '/start.sh';'bash'

# ports 8100 and 35729 used by ionic serve (default ports)
# 17-jul-16 now exposes port 5000 as well in order to run node.js (default port)
# 19-jul-16 now expose ports 3000, 3001 and 3002 to support Angular using lite-server (default port = 3000)
EXPOSE 3000 3001 3002 5000 8100 35729

VOLUME /projects
