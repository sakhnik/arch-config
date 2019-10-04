AddPackage linux # The Linux kernel and modules
AddPackage linux-lts # The Linux-lts kernel and modules
AddPackage systemd-sysvcompat # sysvinit compat for systemd

AddPackage --foreign earlyoom # Early OOM Daemon for Linux
AddPackage --foreign systemd-boot-pacman-hook # Pacman hook to upgrade systemd-boot after systemd upgrade.


cat >"$(CreateFile /etc/systemd/journald.conf.d/00-journal-size.conf)" <<EOF
[Journal]
SystemMaxUse=50M
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

# Lock the system before suspend
cat >"$(CreateFile /etc/systemd/system/i3lock@.service)" <<EOF
[Unit]
Description=Start user i3-locks.h
Before=sleep.target

[Service]
User=%I
Type=forking
Environment=DISPLAY=:0
ExecStartPre=/usr/bin/xkb-switch -s us
ExecStart=/usr/bin/i3lock -c 777777
ExecStartPost=/usr/bin/sleep 1

[Install]
WantedBy=sleep.target
EOF

CopyFile /etc/systemd/system/sshd.socket
CopyFile /etc/systemd/system/sshd@.service

# Enable locking for the user named sakhnik
CreateLink /etc/systemd/system/sleep.target.wants/i3lock@sakhnik.service /etc/systemd/system/i3lock@.service

CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/lightdm.service
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target
CreateLink /etc/systemd/system/sleep.target.wants/root-suspend.service /etc/systemd/system/root-suspend.service
CreateLink /etc/systemd/system/sockets.target.wants/avahi-daemon.socket /usr/lib/systemd/system/avahi-daemon.socket
CreateLink /etc/systemd/system/sockets.target.wants/org.cups.cupsd.socket /usr/lib/systemd/system/org.cups.cupsd.socket
CreateLink /etc/systemd/system/sockets.target.wants/sshd.socket /etc/systemd/system/sshd.socket
CreateLink /etc/systemd/system/suspend.target.wants/root-resume.service /etc/systemd/system/root-resume.service
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
CreateLink /etc/systemd/user/sockets.target.wants/dirmngr.socket /usr/lib/systemd/user/dirmngr.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-browser.socket /usr/lib/systemd/user/gpg-agent-browser.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-extra.socket /usr/lib/systemd/user/gpg-agent-extra.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-ssh.socket /usr/lib/systemd/user/gpg-agent-ssh.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent.socket /usr/lib/systemd/user/gpg-agent.socket
CreateLink /etc/systemd/user/sockets.target.wants/p11-kit-server.socket /usr/lib/systemd/user/p11-kit-server.socket
CreateLink /etc/systemd/user/sockets.target.wants/pulseaudio.socket /usr/lib/systemd/user/pulseaudio.socket

# The station will use systemd-boot
# Boot the stable kernel 4.9 because the touchpad works the best
# with it in Xiaomi Mi Notebook Air 12
cat >"$(CreateFile /boot/loader/loader.conf)" <<EOF
#timeout 3
default arch
EOF

cat >"$(CreateFile /boot/loader/entries/arch-lts.conf)" <<EOF
title   Arch Linux LTS
linux   /vmlinuz-linux-lts
initrd  /intel-ucode.img
initrd  /initramfs-linux-lts.img
options root=PARTUUID=ee2d9278-43e4-4112-a7cc-ee443439f9e9 add_efi_memmap intel_iommu=on acpi_backlight=none zswap.enabled=1
EOF

cat >"$(CreateFile /boot/loader/entries/arch.conf)" <<EOF
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=PARTUUID=ee2d9278-43e4-4112-a7cc-ee443439f9e9 add_efi_memmap intel_iommu=on acpi_backlight=none zswap.enabled=1
EOF

cat >"$(CreateFile /boot/loader/entries/arch-lts49.conf)" <<EOF
title   Arch Linux LTS 4.9
linux   /vmlinuz-linux-lts49
initrd  /intel-ucode.img
initrd  /initramfs-linux-lts49.img
options root=PARTUUID=ee2d9278-43e4-4112-a7cc-ee443439f9e9 add_efi_memmap intel_iommu=on acpi_backlight=none zswap.enabled=1
EOF

# Since /boot is vfat, file properties aren't preserved
SetFileProperty /boot/loader/entries/arch-lts.conf mode 755
SetFileProperty /boot/loader/entries/arch-lts49.conf mode 755
SetFileProperty /boot/loader/entries/arch.conf mode 755
SetFileProperty /boot/loader/loader.conf mode 755

# A script to conveniently build linux-lts49
CopyFile /usr/local/bin/build-linux-lts49.sh 755
