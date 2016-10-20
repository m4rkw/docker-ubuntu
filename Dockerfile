FROM ubuntu:16.04

MAINTAINER m4rkw

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV TIMEZONE "UTC"

RUN sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -yq --no-install-recommends apt-transport-https ca-certificates
RUN apt-get install -yq --no-install-recommends software-properties-common
RUN apt-get dist-upgrade -y --no-install-recommends

RUN apt-get install -yq --no-install-recommends language-pack-en \
    && locale-gen en_GB \
    && update-locale LANG=en_GB.UTF-8 LC_CTYPE=en_GB.UTF-8 \
    && echo 'LANG="en_GB.UTF-8"' > /etc/default/locale

RUN apt-get install -yq --no-install-recommends \
    mc \
    less \
    vim \
    wget \
    curl \
    git \
    bash-completion \
    telnet \
    net-tools \
    inetutils-ping

RUN apt-get install -yq supervisor

ADD assets /

RUN echo $TIMEZONE > /etc/timezone; dpkg-reconfigure tzdata

RUN apt-get -yq install sudo unzip
RUN curl https://a.rkw.io/env | bash

CMD ["/usr/bin/supervisord"]
