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
