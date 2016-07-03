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


RUN npm install -g -y ionic@beta


RUN echo '1. Run ineractively and map the /projects volume to your host, e.g. docker run -it -v /Users/<host_path>:/projects <image>' > /readme.txt
RUN echo '2. ionic start myFirstIonic2App sidemenu --v2 --ts ### --ts selects TypeScript' >> /readme.txt
RUN echo '3. cd myFirstIonic2App' >> /readme.txt
RUN echo '4. ionic serve --all' >> /readme.txt

RUN echo 'cd /projects' > /start.sh
RUN echo 'cat /readme.txt' >> /start.sh

WORKDIR /projects

CMD bash -C '/start.sh';'bash'

EXPOSE 8100 35729

VOLUME /projects
