AddPackage acpid # A daemon for delivering ACPI power management events with netlink support
AddPackage android-udev # Udev rules to connect Android devices to your linux box
AddPackage modprobed-db # Keeps track of EVERY kernel module ever used - useful for make localmodconfig
AddPackage powertop # A tool to diagnose issues with power consumption and power management

cat >"$(CreateFile /etc/udev/rules.d/50-bluetooth.rules)" <<EOF
# disable bluetooth
#SUBSYSTEM=="rfkill", ATTR{type}=="bluetooth", ATTR{state}="0"
EOF

# Apparently, swap is good for system health:
# https://chrisdown.name/2018/01/02/in-defence-of-swap.html
cat >"$(CreateFile /etc/sysctl.d/99-sysctl.conf)" <<EOF
vm.swappiness=60
EOF

cat >"$(CreateFile /etc/tmpfiles.d/10-ioscheduler.conf)" <<EOF
w /sys/block/sda/queue/scheduler - - - - none
EOF

cat >"$(CreateFile /etc/tmpfiles.d/99-powertop.conf)" <<EOF
#Type Path        Mode UID  GID  Age Argument
w    /proc/sys/vm/dirty_writeback_centisecs   - - - - 1500
w    /sys/class/scsi_host/host0/link_power_management_policy  - - - - min_power
w    /sys/class/scsi_host/host1/link_power_management_policy  - - - - min_power
w    /sys/module/snd_hda_intel/parameters/power_save   - - - - 1
w    /proc/sys/kernel/nmi_watchdog   - - - - 0
w    /sys/bus/usb/devices/1-3/power/control   - - - - auto
#w    /sys/bus/i2c/devices/i2c-1/device/power/control   - - - - auto
#w    /sys/bus/i2c/devices/i2c-2/device/power/control   - - - - auto
#w    /sys/bus/i2c/devices/i2c-3/device/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:00:00.0/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:00:02.0/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:00:04.0/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:00:14.0/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:00:16.0/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:00:17.0/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:00:1d.0/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:00:1f.0/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:00:1f.2/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:00:1f.3/power/control   - - - - auto
w    /sys/bus/pci/devices/0000:01:00.0/power/control   - - - - auto
EOF

# Share modprobed-db for all users
CopyFile /etc/modprobed.db '' sakhnik users

CopyFile /etc/acpi/events/anything
CopyFile /etc/acpi/headphone.sh 755
CreateLink /etc/systemd/system/multi-user.target.wants/acpid.service /usr/lib/systemd/system/acpid.service
