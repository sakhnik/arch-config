cat >"$(CreateFile /etc/udev/rules.d/50-bluetooth.rules)" <<EOF
# disable bluetooth
SUBSYSTEM=="rfkill", ATTR{type}=="bluetooth", ATTR{state}="0"
EOF
