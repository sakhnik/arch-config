AddPackage automake # A GNU tool for automatically creating Makefiles
AddPackage dhcpcd # RFC2131 compliant DHCP client daemon
AddPackage dialog # A tool to display dialog boxes from shell scripts
AddPackage fakeroot # Tool for simulating superuser privileges
AddPackage gdb # The GNU Debugger
AddPackage git # the fast distributed version control system
AddPackage inetutils # A collection of common network programs
AddPackage intel-ucode # Microcode update files for Intel CPUs
AddPackage libva-intel-driver # VA-API implementation for Intel G45 and HD Graphics family
AddPackage libva-utils # Intel VA-API Media Applications and Scripts for libva
AddPackage luarocks # Deployment and management system for Lua 5.3 modules
AddPackage npm # A package manager for javascript
AddPackage ntfs-3g # NTFS filesystem driver and utilities
AddPackage p7zip # Command-line file archiver with high compression ratio
AddPackage patch # A utility to apply patch files to original sources
AddPackage perf # Linux kernel performance auditing tool
AddPackage perl-image-exiftool # Reader and rewriter of EXIF informations that supports raw files
AddPackage pwgen # Password generator for creating easily memorable passwords
AddPackage python-netifaces # Portable module to access network interface information in Python
AddPackage qemu # A generic and open source machine emulator and virtualizer
AddPackage rsync # A file transfer program to keep remote files in sync
AddPackage socat # Multipurpose relay
AddPackage sshfs # FUSE client based on the SSH File Transfer Protocol
AddPackage sudo # Give certain users the ability to run some commands as root
AddPackage tk # A windowing toolkit for use with tcl
AddPackage tmux # A terminal multiplexer
AddPackage unrar # The RAR uncompression program
AddPackage usbutils # USB Device Utilities
AddPackage valgrind # Tool to help find memory-management problems in programs
AddPackage wget # Network utility to retrieve files from the Web
AddPackage whois # Intelligent WHOIS client
AddPackage zsh # A very advanced and programmable command interpreter (shell) for UNIX

AddPackage --foreign python-basiciw # Retrieve information such as ESSID or signal quality from wireless cards (Python module)

CreateLink /etc/os-release ../usr/lib/os-release
# Local time zone
CreateLink /etc/localtime /usr/share/zoneinfo/Europe/Kiev

CreateFile /etc/.pwd.lock 600 > /dev/null
CopyFile /etc/group
CopyFile /etc/gshadow
CopyFile /etc/passwd
DecryptFileTo /etc/shadow.gpg /etc/shadow

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

sed -i -f -  "$(GetPackageOriginalFile sudo /etc/sudoers)" <<EOF
s/^#\( %wheel ALL=(ALL) ALL\)$/\1/
EOF


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

10.0.0.3   guard
10.0.1.1   home-alarmpi3
10.0.1.6   home-door
10.0.1.7   home-venus
10.0.2.2   farm-pangea
10.0.2.4   farm-ustia
10.0.2.5   farm-w8
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
