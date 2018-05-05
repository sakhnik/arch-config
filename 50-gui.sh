AddPackage adapta-gtk-theme # An adaptive Gtk+ theme based on Material Design Guidelines
AddPackage adwaita-icon-theme # GNOME standard icons
AddPackage compton # X compositor that may fix tearing issues
AddPackage dmenu # Generic menu for X
AddPackage gnome-themes-extra # Extra Themes for GNOME Applications
AddPackage i3-wm # An improved dynamic tiling window manager
AddPackage i3blocks # Define blocks for your i3bar status line
AddPackage i3lock # An improved screenlocker based upon XCB and PAM
AddPackage i3status # Generates status bar to use with i3bar, dzen2 or xmobar
AddPackage lightdm-gtk-greeter-settings # Settings editor for the LightDM GTK+ Greeter
AddPackage sway # i3 compatible window manager for Wayland
AddPackage xautolock # An automatic X screen-locker/screen-saver
AddPackage xclip # Command line interface to the X11 clipboard
AddPackage xcompmgr # Composite Window-effects manager for X.org
AddPackage xf86-input-libinput # Generic input driver for the X.Org server based on libinput
AddPackage xf86-video-intel # X.org Intel i810/i830/i915/945G/G965+ video drivers
AddPackage xorg-server # Xorg X server
AddPackage xorg-twm # Tab Window Manager for the X Window System
AddPackage xorg-xbacklight # RandR-based backlight control application
AddPackage xorg-xdpyinfo # Display information utility for X
AddPackage xorg-xinit # X.Org initialisation program
AddPackage xorg-xrandr # Primitive command line interface to RandR extension

AddPackage --foreign i3pystatus # i3status replacement written in python for the i3 window manager
AddPackage --foreign xkb-switch # Program that allows to query and change the XKB layout state

cat >"$(CreateFile /etc/X11/xorg.conf.d/00-keyboard.conf)" <<EOF
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbLayout" "us,ua"
    Option "XkbVariant" "altgr-intl,"
    Option "XkbOptions" "grp:caps_toggle,lv3:ralt_switch,compose:rctrl-altgr"
EndSection
EOF

cat >"$(CreateFile /etc/X11/xorg.conf.d/20-intel.conf)" <<EOF
Section "Device"
    Identifier "Intel Graphics"
    Driver "intel"
    BusID "PCI:0:2:0"
    Option "Backlight" "intel_backlight"
    Option "TearFree"   "true"
    Option "AccelMethod" "sna"
    Option "DRI" "3"
EndSection
EOF

cat >"$(CreateFile /etc/X11/xorg.conf.d/30-touchpad.conf)" <<EOF
Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"

    Driver "libinput"
    MatchDevicePath "/dev/input/event*"
    Option "Tapping" "on"
    Option "ClickMethod" "clickfinger"
    Option "NaturalScrolling" "true"

    #Driver "synaptics"
    #Option "VertScrollDelta"          "-46"
    #Option "HorizScrollDelta"         "-46"
    #Option "TapButton1" "1"
    #Option "TapButton2" "3"
    #Option "TapButton3" "2"
    #Option "PalmDetect" "1"
EndSection
EOF

cat >"$(CreateFile /etc/pacman.d/hooks/lightdm-gtk-dark.hook)" <<EOF
[Trigger]
Type = File
Operation = Install
Operation = Upgrade
Target = usr/share/xgreeters/lightdm-gtk-greeter.desktop

[Action]
Description = Updating dark theme for lightdm-gtk-greeter
When = PostTransaction
Exec = /usr/bin/sed -i 's/Exec=lightdm-gtk-greeter/Exec=env GTK_THEME=Adwaita:dark lightdm-gtk-greeter/' usr/share/xgreeters/lightdm-gtk-greeter.desktop
EOF

sed -i -f - "$(GetPackageOriginalFile lightdm-gtk-greeter /etc/lightdm/lightdm-gtk-greeter.conf)" <<EOF
s/^#xft-dpi=/xft-dpi=150/
s/^#xft-hintstyle=/xft-hintstyle=hintslight/
EOF

sed -i -f - "$(GetPackageOriginalFile lightdm /etc/lightdm/lightdm.conf)" <<EOF
s/#greeter-session=.*/greeter-session=lightdm-gtk-greeter/
EOF

CreateLink /etc/fonts/conf.d/10-no-sub-pixel.conf ../conf.avail/10-no-sub-pixel.conf
