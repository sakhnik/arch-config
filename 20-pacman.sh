AddPackage pacman # A library-based package manager with dependency support
AddPackage pacutils # Helper tools for libalpm

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

sed -i '/^## Ukraine/,/^$/ s/^#//' "$(GetPackageOriginalFile pacman-mirrorlist /etc/pacman.d/mirrorlist)"

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
