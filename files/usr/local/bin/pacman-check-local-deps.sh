#!/bin/bash -e

white=`tput setaf 7`
blue=`tput setaf 4`
bold=`tput bold`
reset=`tput sgr 0`

# Upgrading libraries may leave AUR packages broken.
# Let's loop over all installed "foreign" packages, check their linkage
# with ldd and rebuild those with dangling dependency.
echo "${bold}${blue}:: ${white}Checking whether AUR packages need be rebuilt...${reset}"
to_rebuild=
for pkg in `$pacman -Qm | awk '{print $1}'`; do
    # Blacklist: skip known exceptional packages
    grep -q $pkg <<END && continue
linux-lts49
linux-lts49-docs
linux-lts49-headers
END

    printf "\r  Checking %-48s" $pkg
    for f in `$pacman -Ql $pkg | grep -E '/(bin|lib)/.' | awk '{print $2}'`; do
        if [[ -x "$f" ]]; then
            output=$(ldd $f 2>/dev/null || continue)
            if grep -q 'not found' <<< "$output"; then
                to_rebuild="$to_rebuild $pkg"
                break
            fi
        fi
    done
done

if [[ -n "$to_rebuild" ]]; then
    printf "\rTo rebuild: %-48s\n" "$to_rebuild"
    #/usr/bin/pacaur -S $to_rebuild
else
    printf "\rNothing to rebuild %-48s\n" " "
fi
