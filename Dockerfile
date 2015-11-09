FROM debian:latest

MAINTAINER Leonard Marschke <leonard@marschke.me>

#copy sources of grml to image
ADD sources.list.d/* /etc/apt/sources.list.d/

#update software repos
RUN apt-get update \
#ugrade software
    && apt-get -y upgrade \
    && apt-get -y install apt-utils \
#install some useful tools need to build grml (git is needed to use with gitlab ci)
    && apt-get -y install \
        git \
        curl \
        syslinux-common \
        syslinux-utils \
#re-read sources
    && apt-get update \
#install keyring in order to use debbootstrap
    && apt-get --allow-unauthenticated install grml-debian-keyring \
#install grml-live
    && apt-get --no-install-recommends -y --force-yes install \
        grml-live \
        grml-live-addons \
#clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*