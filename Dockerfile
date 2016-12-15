FROM quay.io/nordstrom/baseimage-ubuntu:16.04
MAINTAINER Nordstrom Kubernetes Platform Team "invcldtm@nordstrom.com"

ARG NODEJS_VERSION
ENV NODEJS_VERSION ${NODEJS_VERSION:-4.2.6}~dfsg-1ubuntu4.1

USER root

ADD nodesource.gpg.key /tmp/

RUN apt-key add /tmp/nodesource.gpg.key \
 && echo 'deb https://deb.nodesource.com/node_0.10 xenial main' > /etc/apt/sources.list.d/nodesource.list \
 && apt-get update -qy \
 && apt-get install -qy \
     nodejs=${NODEJS_VERSION} \
     npm

USER ubuntu
