#!/bin/bash

mkdir -p /etc/portage/repos.conf/
echo "[DEFAULT]
main-repo = gentoo

[gentoo]
location = /usr/portage
sync-type = rsync
sync-uri = rsync://rsync.europe.gentoo.org/gentoo-portage
" > /etc/portage/repos.conf/gentoo.conf

# Upgrading packages

rsync -av "rsync://rsync.at.gentoo.org/gentoo-portage/licenses/" "/usr/portage/licenses/" && ls /usr/portage/licenses -1 | xargs -0 > /etc/entropy/packages/license.accept && \
equo u && \
echo -5 | equo conf update
rm -rf /etc/entropy/packages/license.accept

# Remove compilation tools
equo rm --nodeps --force-system autoconf automake bison yacc gcc localepurge

# Writing package list file
equo q list installed -qv > /etc/sabayon-pkglist

equo cleanup


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

# cleaning licenses accepted
rm -rf /etc/entropy/packages/license.accept
rm -rf /usr/portage/licenses


