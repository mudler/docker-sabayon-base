#!/bin/bash

# Setting locale.conf
for f in /etc/env.d/02locale /etc/locale.conf; do
    echo LANG=en_US.UTF-8 > "${f}"
    echo LANGUAGE=en_US.UTF-8 >> "${f}"
    echo LC_ALL=en_US.UTF-8 >> "${f}"
done

# Defyning /usr/local/portage configuration
mkdir /usr/local/portage
mkdir -p /usr/local/portage/metadata/
mkdir -p /usr/local/portage/profiles/
echo "masters = gentoo" > /usr/local/portage/metadata/layout.conf
echo "user_defined" > /usr/local/portage/profiles/repo_name

emerge -C =dev-python/python-exec-0.3.1

mkdir -p /etc/portage/package.keywords/
echo "app-admin/equo ~amd64
sys-apps/entropy ~amd64
" > /etc/portage/package.keywords/00-sabayon.package.keywords

mkdir -p /etc/portage/package.use/
echo "dev-lang/python sqlite
sys-apps/file python
" > /etc/portage/package.use/00-sabayon.package.use


# emerging equo and expect
emerge -vt equo --autounmask-write || exit 1
emerge expect || exit 1

# Choosing only python2.7 for now, cleaning others
eselect python set python2.7

# Removing other versions of python
emerge -C python:3.2 python:3.3

# Specifying a gentoo profile
eselect profile set default/linux/amd64/13.0/desktop

# default to opendns for next stage(s)
echo "nameserver 208.67.222.222" > /etc/resolv.conf

# set default shell
chsh -s /bin/bash

rm -rf /etc/make.profile


