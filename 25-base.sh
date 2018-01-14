AddPackage glibc # GNU C Library
AddPackage f2fs-tools # Tools for Flash-Friendly File System (F2FS)
AddPackage nano # Pico editor clone with enhancements
AddPackage sudo # Give certain users the ability to run some commands as root

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
