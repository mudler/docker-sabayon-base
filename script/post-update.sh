#!/bin/bash

mkdir -p /etc/portage/repos.conf/
echo "[DEFAULT]
main-repo = gentoo

[gentoo]
location = /usr/portage
sync-type = rsync
sync-uri = rsync://rsync.europe.gentoo.org/gentoo-portage
" > /etc/portage/repos.conf/gentoo.conf

# Remove compilation tools
equo rm --nodeps --force-system autoconf automake bison yacc gcc localepurge

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

equo i --nodeps rsync
rsync -av -H -A -X --delete-during "rsync://rsync.at.gentoo.org/gentoo-portage/licenses/" "/usr/portage/licenses/"
ls /usr/portage/licenses -1 | xargs -0 > /etc/entropy/packages/license.accept

# Forcing to reinstall already installed packages
equo i $(equo q list installed -qv  | sed 's/-[0-9]\{1,\}.*$//' | xargs echo)
#equo i $(cat /etc/sabayon-pkglist | xargs echo)

equo i --nodeps grep busybox patch

# cleaning licenses accepted
rm -rf /etc/entropy/packages/license.accept
rm -rf /usr/portage/licenses

# Writing package list file
equo q list installed -qv > /etc/sabayon-pkglist

equo cleanup
