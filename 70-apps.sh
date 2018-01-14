cat >"$(CreateFile /etc/mpv/mpv.conf)" <<EOF
hwdec=vaapi
#vo=opengl
#opengl-backend=wayland
vo=vaapi
EOF
