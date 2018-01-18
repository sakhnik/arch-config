AddPackage autoconf # A GNU tool for automatically configuring source code
AddPackage automake # A GNU tool for automatically creating Makefiles
AddPackage bash # The GNU Bourne Again shell
AddPackage bzip2 # A high-quality data compression program
AddPackage clang # C language family frontend for LLVM
AddPackage coreutils # The basic file, shell and text manipulation utilities of the GNU operating system
AddPackage device-mapper # Device mapper userspace library and tools
AddPackage dhclient # A standalone DHCP client from the dhcp package
AddPackage dhcpcd # RFC2131 compliant DHCP client daemon
AddPackage dialog # A tool to display dialog boxes from shell scripts
AddPackage diffutils # Utility programs used for creating patch files
AddPackage distcc # Distributed C, C++ and Objective-C compiler
AddPackage dosfstools # DOS filesystem utilities
AddPackage e2fsprogs # Ext2/3/4 filesystem utilities
AddPackage easy-rsa # Simple shell based CA utility
AddPackage ethtool # Utility for controlling network drivers and hardware
AddPackage exfat-utils # Utilities for exFAT file system
AddPackage expect # A tool for automating interactive applications
AddPackage f2fs-tools # Tools for Flash-Friendly File System (F2FS)
AddPackage fakeroot # Tool for simulating superuser privileges
AddPackage file # File type identification utility
AddPackage filesystem # Base Arch Linux files
AddPackage findutils # GNU utilities to locate files
AddPackage gawk # GNU version of awk
AddPackage gdb # The GNU Debugger
AddPackage gettext # GNU internationalization library
AddPackage git # the fast distributed version control system
AddPackage glibc # GNU C Library
AddPackage go # Core compiler tools for the Go programming language
AddPackage gzip # GNU compression utility
AddPackage hdparm # A shell utility for manipulating Linux IDE drive/driver parameters
AddPackage htop # Interactive process viewer
AddPackage iftop # Display bandwidth usage on an interface
AddPackage ifuse # A fuse filesystem to access the contents of an iPhone or iPod Touch
AddPackage inetutils # A collection of common network programs
AddPackage intel-ucode # Microcode update files for Intel CPUs
AddPackage intltool # The internationalization tool collection
AddPackage iotop # View I/O usage of processes
AddPackage iproute2 # IP Routing Utilities
AddPackage iputils # Network monitoring tools, including ping
AddPackage jfsutils # JFS filesystem utilities
AddPackage libva-intel-driver # VA-API implementation for Intel G45 and HD Graphics family
AddPackage licenses # Standard licenses distribution package
AddPackage linux-lts # The Linux-lts kernel and modules
AddPackage logrotate # Rotates system logs automatically
AddPackage lsof # Lists open files for running Unix processes
AddPackage luarocks # Deployment and management system for Lua 5.3 modules
AddPackage lvm2 # Logical Volume Manager 2 utilities
AddPackage mdadm # A tool for managing/monitoring Linux md device arrays, also known as Software RAID
AddPackage nano # Pico editor clone with enhancements
AddPackage net-tools # Configuration tools for Linux networking
AddPackage ninja # Small build system with a focus on speed
AddPackage npm # A package manager for javascript
AddPackage nss-mdns # glibc plugin providing host name resolution via mDNS
AddPackage ntfs-3g # NTFS filesystem driver and utilities
AddPackage openssh # Free version of the SSH connectivity tools
AddPackage p7zip # Command-line file archiver with high compression ratio
AddPackage patch # A utility to apply patch files to original sources
AddPackage pciutils # PCI bus configuration space access library and tools
AddPackage perf # Linux kernel performance auditing tool
AddPackage perl # A highly capable, feature-rich programming language
AddPackage perl-image-exiftool # Reader and rewriter of EXIF informations that supports raw files
AddPackage perl-term-readline-gnu # GNU Readline XS library wrapper
AddPackage pkg-config # A system for managing library compile/link flags
AddPackage procps-ng # Utilities for monitoring your system and its processes
AddPackage psmisc # Miscellaneous procfs tools
AddPackage pv # A terminal-based tool for monitoring the progress of data through a pipeline.
AddPackage pwgen # Password generator for creating easily memorable passwords
AddPackage pygmentize # Python syntax highlighter
AddPackage python-dbus # Python 3.6 bindings for DBUS
AddPackage python-hglib # A library with a fast, convenient interface to Mercurial. It uses Mercurial's command server for communication with hg.
AddPackage python-netifaces # Portable module to access network interface information in Python
AddPackage python-pip # The PyPA recommended tool for installing Python packages
AddPackage python-psutil # A cross-platform process and system utilities module for Python
AddPackage python-pygit2 # Python bindings for libgit2
AddPackage python2-dbus # Python 2.7 bindings for DBUS
AddPackage qemu # A generic and open source machine emulator and virtualizer
AddPackage qemu-arch-extra # QEMU for foreign architectures
AddPackage reiserfsprogs # Reiserfs utilities
AddPackage rsync # A file transfer program to keep remote files in sync
AddPackage ruby # An object-oriented language for quick and easy programming
AddPackage s-nail # Mail processing system with a command syntax reminiscent of ed
AddPackage screenfetch # CLI Bash script to show system/theme info in screenshots
AddPackage sed # GNU stream editor
AddPackage shadow # Password and account management tool suite with support for shadow files and PAM
AddPackage socat # Multipurpose relay
AddPackage sshfs # FUSE client based on the SSH File Transfer Protocol
AddPackage sudo # Give certain users the ability to run some commands as root
AddPackage sysfsutils # System Utilities Based on Sysfs
AddPackage tar # Utility used to store, backup, and transport files
AddPackage tcpdump # Powerful command-line packet analyzer
AddPackage tcpreplay # Gives the ability to replay previously captured traffic in a libpcap format
AddPackage testdisk # Checks and undeletes partitions + PhotoRec, signature based recovery tool
AddPackage texinfo # GNU documentation system for on-line information and printed output
AddPackage tftp-hpa # Official tftp server
AddPackage tk # A windowing toolkit for use with tcl
AddPackage tmux # A terminal multiplexer
AddPackage traceroute # Tracks the route taken by packets over an IP network
AddPackage tree # A directory listing program displaying a depth indented list of files
AddPackage unrar # The RAR uncompression program
AddPackage usbutils # USB Device Utilities
AddPackage util-linux # Miscellaneous system utilities for Linux
AddPackage valgrind # Tool to help find memory-management problems in programs
AddPackage vi # The original ex/vi text editor
AddPackage wget # Network utility to retrieve files from the Web
AddPackage which # A utility to show the full path of commands
AddPackage whois # Intelligent WHOIS client
AddPackage wpa_supplicant # A utility providing key negotiation for WPA wireless networks
AddPackage xfsprogs # XFS filesystem utilities
AddPackage yajl # Yet Another JSON Library
AddPackage yasm # A rewrite of NASM to allow for multiple syntax supported (NASM, TASM, GAS, etc.)
AddPackage zsh # A very advanced and programmable command interpreter (shell) for UNIX
AddPackage zsh-completions # Additional completion definitions for Zsh
AddPackage zsh-lovers # A collection of tips, tricks and examples for the Z shell.

AddPackage --foreign binfmt-support # register interpreters for various binary formats
AddPackage --foreign python-basiciw # Retrieve information such as ESSID or signal quality from wireless cards (Python module)

CreateLink /etc/os-release ../usr/lib/os-release
# Local time zone
CreateLink /etc/localtime ../usr/share/zoneinfo/Europe/Kiev

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
