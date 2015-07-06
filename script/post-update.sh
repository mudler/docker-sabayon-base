#!/bin/bash


PACKAGES_TO_REMOVE=(
    "sys-devel/llvm"
    "dev-libs/ppl"
    "app-admin/sudo"
    "x11-libs/gtk+:3"
    "x11-libs/gtk+:2"
    "dev-db/mariadb"
    "sys-fs/ntfs3g"
    "app-accessibility/at-spi2-core"
    "app-accessibility/at-spi2-atk"
    "sys-devel/base-gcc:4.7"
    "sys-devel/gcc:4.7"
    "net-print/cups"
    "dev-util/gtk-update-icon-cache"
    "dev-qt/qtscript"
    "dev-qt/qtchooser"
    "dev-qt/qtcore"
    "app-shells/zsh"
    "app-shells/zsh-pol-config"
    "dev-db/mysql-init-scripts"
    "dev-lang/ruby"
    "app-editors/vim"
    "dev-util/gtk-doc-am"
    "media-gfx/graphite2"
    "x11-apps/xset"
    "x11-themes/hicolor-icon-theme"
    "media-libs/tiff"
    "app-eselect/eselect-lcdfilter"
    "app-eselect/eselect-mesa"
    "app-eselect/eselect-opengl"
    "app-eselect/eselect-qtgraphicssystem"
    "x11-libs/pixman"
    "x11-libs/libvdpau"
    "x11-libs/libxshmfence"
    "x11-libs/libXxf86vm"
    "x11-libs/libXinerama"
    "x11-libs/libXdamage"
    "x11-libs/libXcursor"
    "x11-libs/libXfixes"
    "x11-libs/libXv"
    "x11-libs/libXcomposite"
    "x11-libs/libXrandr"
    "media-libs/jbig2dec"
    "dev-libs/libcroco"
    "app-text/qpdf"
    "media-fonts/urw-fonts"
    "app-text/libpaper"
    "dev-python/snakeoil"
    "dev-libs/atk"
    "dev-perl/DBI"
    "perl-core/Digest-MD5"
    "perl-core/MIME-Base64"
    "perl-core/File-Temp"
    "perl-core/ExtUtils-MakeMaker"
    "perl-core/Params-Check"
    "perl-core/Module-CoreList"
    "perl-core/Digest"
    "dev-perl/TermReadKey"
    "dev-perl/Test-Deep"
    "virtual/perl-IO-Zlib"
    "virtual/perl-Package-Constants"
    "virtual/perl-Term-ANSIColor"
    "virtual/perl-Time-HiRes"
    "app-text/asciidoc"
    "app-text/sgml-common"
    "virtual/python-argparse"
    "sys-power/upower"
    "dev-python/py"
    "dev-vcs/git"
    "dev-tcltk/expect"
    "app-admin/python-updater"
    "app-portage/eix"
    "app-portage/gentoolkit"
    "app-portage/gentoopm"
)

FILES_TO_REMOVE=(
   "/.viminfo"
   "/.history"
   "/.zcompdump"
   "/var/log/emerge.log"
   "/var/log/emerge-fetch.log"
   "/equo-rescue-generate.exp"
   "/equo.sql"
   "/generate-equo-db.sh"
   "/post-upgrade.sh"
   "/sabayon-configuration-build.sh"
   "/sabayon-configuration.sh"
   "/post-upgrade.sh"
   "/usr/portage/metadata/md5-cache/*"
   "/var/log/emerge/*"
   "/var/log/entropy/*"
   "/root/*"
   "/root/.*"
   "/etc/zsh"
   "/post-update.sh"
   "/etc/entropy/packages/license.accept"
   "/usr/portage/licenses"
)

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
# Remove packages
equo rm --deep --configfiles --force-system "${PACKAGES_TO_REMOVE[@]}"

# Writing package list file
equo q list installed -qv > /etc/sabayon-pkglist

# Cleanup
equo cleanup
rm -rf "${FILES_TO_REMOVE[@]}"
