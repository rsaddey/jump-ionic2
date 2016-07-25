# No thrills Ionic 2 and Angular 2 developer environment
# See https://blog.saddey.net/2016/07/03/using-docker-to-create-ionic-2-pwa-developer-environment
#
# docker run --name jump-ionic2 -it \
#            -p 3000:3000 -p 3001:3001 -p 3003:3003 -p 5000:5000 \
#            -p 8100:8100 -p 8080:8080 -p 9876:9876 -p 35729:35729 \
#            -v /Users/rsaddey/Documents/PreApproval/Dockers/projects/:/projects \
#            rsaddey/jump-ionic2
#

FROM ubuntu:16.04

MAINTAINER Reiner Saddey <reiner@saddey.net>

LABEL Description="Interactive Ionic 2 Framework example using volume /projects as the root for your app directories"

RUN apt-get update

RUN apt-get install -y -q curl

# As of 03-jul-16: Ionic is not yet ready for Node.js 6, see https://github.com/driftyco/ionic-cli/issues/960
# RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

# nodejs includes matching npm as well
# 25-jul-16: bzip2 and libfontconfig needed by npm install phantomjs (e.g. for Karma testing)
RUN apt-get install -y -q \
    nodejs \
    bzip2 \
    libfontconfig \
    && apt-get -y autoclean \
    && rm -rf /var/lib/apt/lists/*

# As of 03-jul-16: You have been warned, DO NOT push this button: RUN npm update -g npm
# https://github.com/npm/npm/issues/9863 Reinstalling npm v3 fails on Docker


# 17-jul-16 global gulp needed for gulp build --typescheck on Ionic framework sources
## RUN npm install -g --unsafe-perm -y gulp@3.9.1
## RUN npm install -g --unsafe-perm -y ionic@beta
# 19-jul-16 support Angular 2 dev
## RUN npm install --unsafe-perm -g -y typescript typings lite-server concurrently angular-cli

# 25-jul-16: Single RUN install instead of multiple ones
RUN npm install --unsafe-perm -g -y \
                gulp@3.9.1 ionic@beta typescript typings \
                lite-server concurrently angular-cli

COPY readme.txt /readme.txt
COPY start.sh /start.sh

WORKDIR /projects

CMD bash -C '/start.sh';'bash'

# ports 8100 and 35729 used by ionic serve (default ports)
# 17-jul-16 expose port 5000 as well in order to run node.js (default port)
# 19-jul-16 expose ports 3000, 3001 and 3002 to support Angular using lite-server (default port = 3000)
# 25-jul-16 expose port 8080 for webpackServer
# 25-jul-16 expose port 9876 for Karma
EXPOSE 3000 3001 3002 5000 8100 8080 9876 35729

VOLUME /projects
