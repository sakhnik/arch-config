#!/bin/bash -ex

version=`curl https://www.kernel.org 2>/dev/null | perl -ne 'print "$1" if /linux-4\.9\.(\d+).tar.xz/'`
[[ $# -eq 1 ]] && version=$1

echo "Building 4.9.$version"

cd /tmp
[[ -d linux-lts49 ]] && rm -rf linux-lts49
auracle download linux-lts49
cd linux-lts49
sed -i -f - PKGBUILD <<END
/^pkgver=/ s/4\.9\.[0-9]\+/4.9.$version/
s/make -s/make/
/load configuration/ i make LSMOD=/etc/modprobed.db localmodconfig
END

updpkgsums

$EDITOR PKGBUILD

nice -n 19 ionice -c 3 makepkg

sudo pacman -U linux-lts49-4*.tar.xz linux-lts49-headers*.tar.xz
