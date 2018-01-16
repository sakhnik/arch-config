AddPackage encfs # Encrypted filesystem in user-space
AddPackage make # GNU make utility to maintain groups of programs
AddPackage man-db # A utility for reading man pages
AddPackage man-pages # Linux man pages
AddPackage mc # Midnight Commander is a text based filemanager/shell that emulates Norton Commander
AddPackage mercurial # A scalable distributed SCM tool
AddPackage mpv # a free, open source, and cross-platform media player
AddPackage pass # Stores, retrieves, generates, and synchronizes passwords securely
AddPackage sshuttle # Transparent proxy server that forwards all TCP packets over ssh
AddPackage stow # Manage installation of multiple softwares in the same directory tree
AddPackage strace # A diagnostic, debugging and instructional userspace tracer
AddPackage --foreign bindfs # A FUSE filesystem for mirroring a directory to another directory, similar to 'mount --bind', with permission settings.
AddPackage --foreign ledger # Double-entry accounting system with a command-line reporting interface

CreateLink /etc/mc/mc.keymap mc.default.keymap
SetFileProperty /etc/mc/mc.keymap mode 777

cat >"$(CreateFile /etc/mpv/mpv.conf)" <<EOF
hwdec=vaapi
#vo=opengl
#opengl-backend=wayland
vo=vaapi
EOF
