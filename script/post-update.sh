#!/bin/bash

# Remove compilation tools
equo rm --nodeps --force-system autoconf automake bison yacc binutils libtool gcc localepurge

# Remove scripts
rm -rf /equo-rescue-generate.exp
rm -rf /equo.sql
rm -rf /generate-equo-db.sh
rm -rf /post-upgrade.sh
rm -rf /sabayon-configuration-build.sh
rm -rf /sabayon-configuration.sh
rm -rf /post-upgrade.sh

# Cleaning portage metadata cache
rm -rf /usr/portage/metadata/md5-cache/*
rm -rf /var/log/emerge/*
rm -rf /var/log/entropy/*
rm -rf /root/* /root/.*
rm -rf /etc/zsh

rm -rf /post-update.sh

# Writing package list file
equo q list installed -qv > /etc/sabayon-pkglist
