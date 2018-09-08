AddPackage nfs-utils # Support programs for Network File Systems
AddPackage tinc # VPN (Virtual Private Network) daemon

CreateLink /etc/systemd/system/multi-user.target.wants/tinc.service /usr/lib/systemd/system/tinc.service

###########################################################
# Beefarm network

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

###########################################################
# Home network

cat >"$(CreateFile /etc/tinc/home/tinc.conf)" <<EOF
Name = kionia
AddressFamily = ipv4
Device = /dev/net/tun
ConnectTo = alarmpi3
EOF

cat >"$(CreateFile /etc/tinc/home/tinc-up 755)" <<'EOF'
#!/bin/sh
ip link set $INTERFACE up
ip addr add  10.0.1.2/24 dev $INTERFACE
EOF

cat >"$(CreateFile /etc/tinc/home/tinc-down 755)" <<'EOF'
#!/bin/sh
ip addr del 10.0.1.2/24 dev $INTERFACE
ip link set $INTERFACE down
EOF

DecryptFileTo /etc/tinc/home/rsa_key.priv.gpg /etc/tinc/home/rsa_key.priv
SetFileProperty /etc/tinc/home/rsa_key.priv mode 600

CopyFile /etc/tinc/home/hosts-git/alarmpi3 '' sakhnik users
CopyFile /etc/tinc/home/hosts-git/kionia '' sakhnik users
CopyFile /etc/tinc/home/hosts-git/land '' sakhnik users
CopyFile /etc/tinc/home/hosts-git/potter '' sakhnik users
CopyFile /etc/tinc/home/hosts-git/potter2 '' sakhnik users
SetFileProperty /etc/tinc/home/hosts-git group users
SetFileProperty /etc/tinc/home/hosts-git owner sakhnik
CreateLink /etc/tinc/home/hosts/alarmpi3 ../hosts-git/alarmpi3
CreateLink /etc/tinc/home/hosts/kionia ../hosts-git/kionia


###########################################################
# Farm network

cat >"$(CreateFile /etc/tinc/farm/tinc.conf)" <<EOF
Name = kionia
AddressFamily = ipv4
Device = /dev/net/tun
ConnectTo = alarmpi3
EOF

cat >"$(CreateFile /etc/tinc/farm/tinc-up 755)" <<'EOF'
#!/bin/sh
ip link set $INTERFACE up
ip addr add  10.0.2.3/24 dev $INTERFACE
EOF

cat >"$(CreateFile /etc/tinc/farm/tinc-down 755)" <<'EOF'
#!/bin/sh
ip addr del 10.0.2.3/24 dev $INTERFACE
ip link set $INTERFACE down
EOF

DecryptFileTo /etc/tinc/farm/rsa_key.priv.gpg /etc/tinc/farm/rsa_key.priv
SetFileProperty /etc/tinc/farm/rsa_key.priv mode 600

CopyFile /etc/tinc/farm/tinc-farm/alarmpi3 '' sakhnik users
CopyFile /etc/tinc/farm/tinc-farm/kionia '' sakhnik users
CopyFile /etc/tinc/farm/tinc-farm/pangea '' sakhnik users
SetFileProperty /etc/tinc/farm/tinc-farm group users
SetFileProperty /etc/tinc/farm/tinc-farm owner sakhnik
CreateLink /etc/tinc/farm/hosts/alarmpi3 ../tinc-farm/alarmpi3
CreateLink /etc/tinc/farm/hosts/kionia ../tinc-farm/kionia
CreateLink /etc/tinc/farm/hosts/pangea ../tinc-farm/pangea
CreateLink /etc/systemd/system/tinc.service.wants/tinc@farm.service /usr/lib/systemd/system/tinc@.service
