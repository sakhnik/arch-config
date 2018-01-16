AddPackage make # GNU make utility to maintain groups of programs
AddPackage man-db # A utility for reading man pages
AddPackage man-pages # Linux man pages
AddPackage mc # Midnight Commander is a text based filemanager/shell that emulates Norton Commander
AddPackage mercurial # A scalable distributed SCM tool
AddPackage mpv # a free, open source, and cross-platform media player

CreateLink /etc/mc/mc.keymap mc.default.keymap
SetFileProperty /etc/mc/mc.keymap mode 777

cat >"$(CreateFile /etc/mpv/mpv.conf)" <<EOF
hwdec=vaapi
#vo=opengl
#opengl-backend=wayland
vo=vaapi
EOF
