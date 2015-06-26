#!/bin/bash
# fetch the bits!
cd /opt
git clone git://github.com/Sabayon/build.git sabayon-build
cd /opt/sabayon-build/conf/intel/portage
# keep your specific stuff in "myconf" branch:
git checkout -b myconf
# symlink to your <arch>:
ln -sf make.conf.amd64 make.conf
ln -sf package.env.amd64 package.env
# add & commit
git add make.conf package.env
git config --global user.name "root"
git config --global user.email "root@localhost"
git commit -m "saving my configurations"
# rename the gentoo /etc/make.conf and /etc/portage/:
cd /etc/
mv portage portage-gentoo
#mv make.conf make.conf-gentoo
# symlink to sabayon /etc/make.conf /etc/portage/:
ln -sf /opt/sabayon-build/conf/intel/portage portage
