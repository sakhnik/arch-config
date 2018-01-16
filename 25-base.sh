AddPackage git # the fast distributed version control system
AddPackage glibc # GNU C Library
AddPackage f2fs-tools # Tools for Flash-Friendly File System (F2FS)
AddPackage nano # Pico editor clone with enhancements
AddPackage sudo # Give certain users the ability to run some commands as root
AddPackage zsh # A very advanced and programmable command interpreter (shell) for UNIX
AddPackage zsh-completions # Additional completion definitions for Zsh
AddPackage zsh-lovers # A collection of tips, tricks and examples for the Z shell.

# Local time zone
CreateLink /etc/localtime /usr/share/zoneinfo/Europe/Kiev

# Specify locales
f="$(GetPackageOriginalFile glibc /etc/locale.gen)"
sed -i 's/^#\(en_US.UTF-8\)/\1/g' "$f"
sed -i 's/^#\(uk_UA.UTF-8\)/\1/g' "$f" # for ISO timestamps

cat >"$(CreateFile /etc/locale.conf)" <<EOF
LANG=uk_UA.UTF-8
EOF

cat >"$(CreateFile /etc/vconsole.conf)" <<EOF
KEYMAP=us
FONT=LatArCyrHeb-19
EOF

sed -i 's/^#\( %wheel ALL=(ALL) ALL\)$/\1/' "$(GetPackageOriginalFile sudo /etc/sudoers)"

cat >>"$(GetPackageOriginalFile filesystem /etc/shells)" <<EOF
/bin/zsh
/usr/bin/zsh
/usr/bin/git-shell
EOF

cat >>"$(GetPackageOriginalFile filesystem /etc/hosts)" <<EOF

#<ip-address>	<hostname.domain.org>	<hostname>
127.0.0.1	localhost.localdomain	localhost
::1		localhost.localdomain	localhost
127.0.1.1	kionia.localdomain	kionia

188.166.120.156 iryska.do
172.31.149.160 pangea
176.122.93.103  home
EOF

cat >"$(CreateFile /etc/hostname)" <<EOF
kionia
EOF

cat >>"$(GetPackageOriginalFile filesystem /etc/fstab)" <<EOF
# /dev/sda1
UUID=5c1c1997-4ce5-4d59-a7be-903861fddfa2	/         	ext4      	rw,noatime,discard,data=ordered	0 1

# /dev/sda3
UUID=2eb39e0d-1767-43fb-9787-794b452d452c	none      	swap      	discard  	0 0

UUID=B8E9-4294					/boot		vfat		defaults	0 0
EOF

sed -i -f - "$(GetPackageOriginalFile util-linux /etc/pam.d/login)" <<EOF
/^account/ i -auth       optional     pam_gnome_keyring.so
\$a -session    optional     pam_gnome_keyring.so        auto_start
EOF

sed -i -f - "$(GetPackageOriginalFile shadow /etc/pam.d/passwd)" <<EOF
\$a -password	optional	pam_gnome_keyring.so
EOF
