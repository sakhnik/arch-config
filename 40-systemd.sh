AddPackage systemd-sysvcompat # sysvinit compat for systemd
AddPackage --foreign systemd-boot-pacman-hook # Pacman hook to upgrade systemd-boot after systemd upgrade.

cat >"$(CreateFile /etc/systemd/journald.conf.d/00-journal-size.conf)" <<EOF
[Journal]
SystemMaxUse=50M
EOF

cat >"$(CreateFile /etc/systemd/network/25-wireless.network)" <<EOF
[Match]
Name=wlp1s0

[Network]
DHCP=ipv4
EOF

cat >"$(CreateFile /etc/systemd/system/root-suspend.service)" <<EOF
[Unit]
Description=Local system suspend actions
Before=sleep.target

[Service]
Type=simple
ExecStart=-/usr/bin/rmmod tpm_tis tpm_crb tpm_tis_core tpm

[Install]
WantedBy=sleep.target
EOF

cat >"$(CreateFile /etc/systemd/system/root-resume.service)" <<EOF
[Unit]
Description=Local system resume actions
After=suspend.target

[Service]
Type=oneshot
ExecStart=/usr/bin/modprobe tpm_crb
ExecStart=/usr/bin/modprobe tpm_tis

[Install]
WantedBy=suspend.target
EOF

CreateLink /etc/resolv.conf /run/systemd/resolve/resolv.conf
SetFileProperty /etc/resolv.conf mode 777
CreateLink /etc/systemd/system/dbus-org.freedesktop.NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.network1.service /usr/lib/systemd/system/systemd-networkd.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service /usr/lib/systemd/system/NetworkManager-dispatcher.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.resolve1.service /usr/lib/systemd/system/systemd-resolved.service
CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/lightdm.service
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target
CreateLink /etc/systemd/system/multi-user.target.wants/systemd-networkd.service /usr/lib/systemd/system/systemd-networkd.service
CreateLink /etc/systemd/system/multi-user.target.wants/systemd-resolved.service /usr/lib/systemd/system/systemd-resolved.service
CreateLink /etc/systemd/system/multi-user.target.wants/wpa_supplicant@wlp1s0.service /usr/lib/systemd/system/wpa_supplicant@.service
CreateLink /etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service /usr/lib/systemd/system/systemd-networkd-wait-online.service
CreateLink /etc/systemd/system/sleep.target.wants/root-suspend.service /etc/systemd/system/root-suspend.service
CreateLink /etc/systemd/system/sockets.target.wants/avahi-daemon.socket /usr/lib/systemd/system/avahi-daemon.socket
CreateLink /etc/systemd/system/sockets.target.wants/org.cups.cupsd.socket /usr/lib/systemd/system/org.cups.cupsd.socket
CreateLink /etc/systemd/system/sockets.target.wants/sshd.socket /usr/lib/systemd/system/sshd.socket
CreateLink /etc/systemd/system/sockets.target.wants/systemd-networkd.socket /usr/lib/systemd/system/systemd-networkd.socket
CreateLink /etc/systemd/system/suspend.target.wants/root-resume.service /etc/systemd/system/root-resume.service
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
CreateLink /etc/systemd/user/sockets.target.wants/dirmngr.socket /usr/lib/systemd/user/dirmngr.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-browser.socket /usr/lib/systemd/user/gpg-agent-browser.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-extra.socket /usr/lib/systemd/user/gpg-agent-extra.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-ssh.socket /usr/lib/systemd/user/gpg-agent-ssh.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent.socket /usr/lib/systemd/user/gpg-agent.socket
CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
CreateLink /etc/systemd/user/sockets.target.wants/pulseaudio.socket /usr/lib/systemd/user/pulseaudio.socket

# The station will use systemd-boot
cat >"$(CreateFile /boot/loader/loader.conf)" <<EOF
#timeout 3
default arch-lts
EOF

cat >"$(CreateFile /boot/loader/entries/arch-lts.conf)" <<EOF
title   Arch Linux LTS
linux   /vmlinuz-linux-lts
initrd  /intel-ucode.img
initrd  /initramfs-linux-lts.img
options root=PARTUUID=ee2d9278-43e4-4112-a7cc-ee443439f9e9 add_efi_memmap intel_iommu=on acpi_backlight=none zswap.enabled=1
EOF

# Since /boot is vfat, file properties aren't preserved
SetFileProperty /boot/loader/entries/arch-lts.conf mode 755
SetFileProperty /boot/loader/loader.conf mode 755
SetFileProperty /boot/vmlinuz-linux-lts mode 755
