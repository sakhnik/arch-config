AddPackage tinc # VPN (Virtual Private Network) daemon


cat >"$(CreateFile /etc/tinc/beefarm/tinc.conf)" <<EOF
Name = kionia
AddressFamily = ipv4
Device = /dev/net/tun
ConnectTo = iryska
EOF

cat >"$(CreateFile /etc/tinc/beefarm/tinc-up 755)" <<'EOF'
#!/bin/sh
ip link set $INTERFACE up
ip addr add  10.0.0.2/24 dev $INTERFACE
EOF

cat >"$(CreateFile /etc/tinc/beefarm/tinc-down 755)" <<'EOF'
#!/bin/sh
ip addr del 10.0.0.2/24 dev $INTERFACE
ip link set $INTERFACE down
EOF

DecryptFileTo /etc/tinc/beefarm/rsa_key.priv.gpg /etc/tinc/beefarm/rsa_key.priv
SetFileProperty /etc/tinc/beefarm/rsa_key.priv mode 600

CopyFile /etc/tinc/beefarm/hosts-git/guard '' sakhnik users
CopyFile /etc/tinc/beefarm/hosts-git/handy '' sakhnik users
CopyFile /etc/tinc/beefarm/hosts-git/iryska '' sakhnik users
CopyFile /etc/tinc/beefarm/hosts-git/kionia '' sakhnik users
CopyFile /etc/tinc/beefarm/hosts-git/win '' sakhnik users
SetFileProperty /etc/tinc/beefarm/hosts-git group users
SetFileProperty /etc/tinc/beefarm/hosts-git owner sakhnik

CreateLink /etc/tinc/beefarm/hosts/guard ../hosts-git/guard
CreateLink /etc/tinc/beefarm/hosts/iryska ../hosts-git/iryska
CreateLink /etc/tinc/beefarm/hosts/kionia ../hosts-git/kionia
