#!/bin/bash


export LANG=en_US.UTF-8

cower -u

kernel_actual=`pacman -Qi linux-lts49 | perl -ne 'print "$1" if /Version\s+:\s+4\.9\.(\d+)/'`
kernel_available=`curl https://www.kernel.org 2>/dev/null | perl -ne 'print "$1" if /linux-4\.9\.(\d+).tar.xz/'`
if [[ "$kernel_actual" -lt "$kernel_available" ]]; then
	echo "New linux-lts49 version is available: $kernel_available (installed: $kernel_actual)"
fi
