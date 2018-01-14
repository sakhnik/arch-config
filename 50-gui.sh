cat >"$(CreateFile /etc/X11/xorg.conf.d/00-keyboard.conf)" <<EOF
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us,ua"
        Option "XkbVariant" ","
        Option "XkbOptions" "grp:caps_toggle,lv3:ralt_switch,compose:rctrl-altgr"
EndSection
EOF

cat >"$(CreateFile /etc/X11/xorg.conf.d/20-intel.conf)" <<EOF
Section "Device"
	Identifier "Intel Graphics" 
	Driver "intel" 
	BusID "PCI:0:2:0"
	Option "Backlight" "intel_backlight" 
	Option "TearFree" 	"true"
	Option "AccelMethod" "sna"
	Option "DRI" "3"
EndSection
EOF

cat >"$(CreateFile /etc/X11/xorg.conf.d/30-touchpad.conf)" <<EOF
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
	Option "Tapping" "on"
	Option "ClickMethod" "clickfinger"
	Option "NaturalScrolling" "true"
EndSection
EOF

lightdm_gtk_sed_cmd="/usr/bin/sed -i 's/Exec=lightdm-gtk-greeter/Exec=env GTK_THEME=Adwaita:dark lightdm-gtk-greeter/'"
lightdm_gtk_desktop=usr/share/xgreeters/lightdm-gtk-greeter.desktop

cat >"$(CreateFile /etc/pacman.d/hooks/lightdm-gtk-dark.hook)" <<EOF
[Trigger]
Type = File
Operation = Install
Operation = Upgrade
Target = usr/share/xgreeters/lightdm-gtk-greeter.desktop

[Action]
Description = Updating dark theme for lightdm-gtk-greeter
When = PostTransaction
Exec = $lightdm_gtk_sed_cmd $lightdm_gtk_desktop
EOF

eval "$lightdm_gtk_sed_cmd $(GetPackageOriginalFile lightdm-gtk-greeter /${lightdm_gtk_desktop})"
