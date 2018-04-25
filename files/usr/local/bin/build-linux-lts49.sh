#!/bin/bash -ex

die() {
    echo >&2 "$@"
    exit 1
}

[[ $# -eq 1 ]] || die "Usage: `basename $0` patch"
version=$1

cd /tmp
[[ -d linux-lts49 ]] && rm -rf linux-lts49
cower -d linux-lts49
cd linux-lts49
sed -i -f - PKGBUILD <<END
/^pkgver=/ s/4\.9\.[0-9]\+/4.9.$version/
s/make -s/make/
/load configuration/ i make LSMOD=\$HOME/.config/modprobed.db localmodconfig
END

updpkgsums
nice -n 19 ionice -c 3 makepkg
