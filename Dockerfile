FROM debian:latest

MAINTAINER Leonard Marschke <leonard@marschke.me>

#update software repos
RUN apt update

#ugrade software
RUN apt -y upgrade

RUN apt -y install apt-utils

#install some useful tools need to build grml (git is needed to use with gitlab ci)
RUN apt -y install \
        git \
        syslinux-common \
        syslinux-utils

#copy sources of grml to image
ADD sources.list.d/* /etc/apt/sources.list.d/

#re-read sources
RUN apt update

#install keyring in order to use debbootstrap
RUN apt-get --allow-unauthenticated install grml-debian-keyring

#install grml-live
RUN apt-get --no-install-recommends -y --force-yes install grml-live \
        grml-live-addons

#clean up
RUN apt-get clean

RUN rm -rf /var/lib/apt/lists/*