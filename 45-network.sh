AddPackage n2n # A Peer-to-peer VPN software which makes it easy to create virtual networks bypassing intermediate firewalls
AddPackage network-manager-applet # Applet for managing network connections
AddPackage networkmanager # Network connection manager and user applications
AddPackage nfs-utils # Support programs for Network File Systems
AddPackage nm-connection-editor # NetworkManager GUI connection editor and widgets
AddPackage ntp # Network Time Protocol reference implementation
AddPackage tinc-pre # VPN (Virtual Private Network) daemon (Pre-release)


CreateLink /etc/systemd/system/dbus-org.freedesktop.NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service /usr/lib/systemd/system/NetworkManager-dispatcher.service
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service /usr/lib/systemd/system/NetworkManager-wait-online.service


cat >"$(CreateFile /etc/systemd/network/25-wireless.network)" <<EOF
[Match]
Name=wifi

[Network]
DHCP=yes
EOF

cat >"$(CreateFile /etc/systemd/network/20-enp.network)" <<EOF
[Match]
Name=enp*

[Network]
DHCP=yes
EOF

cat >"$(CreateFile /etc/udev/rules.d/10-network.rules)" <<EOF
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="00:c2:c6:ea:83:91", NAME="wifi"
EOF

# Avoid race, iwd should start after the interface renamed.
# Otherwise, the interface couldn't be renamed because "busy".
cat >"$(CreateFile /etc/systemd/system/iwd.service.d/override.conf)" <<EOF
[Unit]
BindsTo=sys-subsystem-net-devices-wifi.device
After=sys-subsystem-net-devices-wifi.device
EOF


CreateLink /etc/systemd/system/multi-user.target.wants/tinc.service /usr/lib/systemd/system/tinc.service

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
CopyFile /etc/tinc/home/hosts-git/door 600 sakhnik users
CopyFile /etc/tinc/home/hosts-git/venus '' sakhnik users
SetFileProperty /etc/tinc/home/hosts-git group users
SetFileProperty /etc/tinc/home/hosts-git owner sakhnik
CreateLink /etc/tinc/home/hosts/alarmpi3 ../hosts-git/alarmpi3
CreateLink /etc/tinc/home/hosts/kionia ../hosts-git/kionia
CreateLink /etc/tinc/home/hosts/door ../hosts-git/door
CreateLink /etc/tinc/home/hosts/venus ../hosts-git/venus


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
CopyFile /etc/tinc/farm/tinc-farm/ustia '' sakhnik users
CopyFile /etc/tinc/farm/tinc-farm/w8 '' sakhnik users
SetFileProperty /etc/tinc/farm/tinc-farm group users
SetFileProperty /etc/tinc/farm/tinc-farm owner sakhnik
CreateLink /etc/tinc/farm/hosts/alarmpi3 ../tinc-farm/alarmpi3
CreateLink /etc/tinc/farm/hosts/kionia ../tinc-farm/kionia
CreateLink /etc/tinc/farm/hosts/pangea ../tinc-farm/pangea
CreateLink /etc/tinc/farm/hosts/ustia ../tinc-farm/ustia
CreateLink /etc/tinc/farm/hosts/w8 ../tinc-farm/w8
CreateLink /etc/systemd/system/tinc.service.wants/tinc@farm.service /usr/lib/systemd/system/tinc@.service
