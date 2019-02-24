AddPackage pacman # A library-based package manager with dependency support
AddPackage pacman-contrib # Contributed scripts and tools for pacman systems
AddPackage pacutils # Helper tools for libalpm
AddPackage --foreign nlohmann-json # Header-only JSON library for Modern C++
AddPackage --foreign yay-bin # Yet another yogurt. Pacman wrapper and AUR helper written in go. Pre-compiled.

cat >"$(CreateFile /etc/pacman.d/hooks/paccache-remove.hook)" <<EOF
[Trigger]
Operation = Remove
Type = Package
Target = *

[Action]
Description = Cleaning pacman cache...
When = PostTransaction
Exec = /usr/bin/paccache -ruk0
EOF

cat >"$(CreateFile /etc/pacman.d/hooks/paccache-upgrade.hook)" <<EOF
[Trigger]
Operation = Upgrade
Type = Package
Target = *

[Action]
Description = Cleaning pacman cache...
When = PostTransaction
Exec = /usr/bin/paccache -rk2
EOF

cat >"$(CreateFile /etc/pacman.d/hooks/check-deps.hook)" <<EOF
[Trigger]
Operation = Upgrade
Type = Package
Target = *

[Action]
Description = Checking broken dependencies...
When = PostTransaction
Exec = /usr/local/bin/pacman-check-local-deps.sh
EOF

CopyFile /usr/local/bin/pacman-check-local-deps.sh 755

cat >"$(CreateFile /etc/pacman.d/hooks/check-updates.hook)" <<EOF
[Trigger]
Operation = Upgrade
Type = Package
Target = *

[Action]
Description = Checking for upstream updates...
When = PostTransaction
Exec = /usr/local/bin/check-upstream-updates.sh
EOF

CopyFile /usr/local/bin/check-upstream-updates.sh 755

sed -i -f - "$(GetPackageOriginalFile pacman-mirrorlist /etc/pacman.d/mirrorlist)" <<EOF
4 a
4 a Server = http://mirrors.nix.org.ua/linux/archlinux/\$repo/os/\$arch
4 a Server = https://mirrors.nix.org.ua/linux/archlinux/\$repo/os/\$arch
EOF

sed -i -f - "$(GetPackageOriginalFile pacman /etc/pacman.conf)" <<EOF
/^#Color/ s/^#//
/^#TotalDownload/ s/^#//
/^#CheckSpace/ s/^#//
/^#VerbosePkgLists/ s/^#//
/VerbosePkgLists/ a ILoveCandy
/#\[testing\]/,/^$/ s/^#//
/#\[community-testing\]/,/^$/ s/^#//
/#\[multilib-testing\]/,/^$/ s/^#//
/#\[multilib\]/,/^$/ s/^#//
EOF

sed -i -f - "$(GetPackageOriginalFile pacman /etc/makepkg.conf)" <<EOF
s/^#MAKEFLAGS=.*/MAKEFLAGS="-j5"/
s/^COMPRESSXZ=.*/COMPRESSXZ=(xz -c -z - --threads=0)/
s/-march=[^ ]*/-march=native/
s/-mtune=[^ ]*/-mtune=native/
EOF
