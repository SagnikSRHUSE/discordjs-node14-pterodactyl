FROM node:14-buster

MAINTAINER Sagnik Sasmal, <sagnik@sagnik.me>

# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive

# Install OS deps
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get -y install dirmngr curl software-properties-common locales git cmake \
    && apt-get -y install autoconf automake g++ libtool \
    && apt-get -y install ffmpeg libmp3lame-dev x264 \
    && apt-get -y install sqlite3 libsqlite3-dev \
    && useradd -m -d /home/container container

# Ensure UTF-8
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen
    
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

USER container
ENV USER=container HOME=/home/container

ENV NPM_CONFIG_PREFIX=/home/container/.npm-global

# Install NodeJS Dependencies
RUN npm install -g discord.js \
    && npm install -g @discordjs/opus \
    && npm install -g opusscript \
    && npm install -g bufferutil \
    && npm install -g libsodium-wrappers \
    && npm install -g sqlite3 \
    && npm install -g better-sqlite3 \
    && npm install -g utf-8-validate \
    && npm install -g ffmpeg \
    && npm install -g sodium

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
