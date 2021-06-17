AddPackage adapta-gtk-theme # An adaptive Gtk+ theme based on Material Design Guidelines
AddPackage adwaita-icon-theme # GNOME standard icons
AddPackage compton # X compositor that may fix tearing issues
AddPackage dmenu # Generic menu for X
AddPackage gnome-themes-extra # Extra Themes for GNOME Applications
AddPackage gnu-free-fonts # A free family of scalable outline fonts
AddPackage i3-wm # An improved dynamic tiling window manager
AddPackage i3blocks # Define blocks for your i3bar status line
AddPackage i3lock # An improved screenlocker based upon XCB and PAM
AddPackage i3status # Generates status bar to use with i3bar, dzen2 or xmobar
AddPackage opendesktop-fonts # Chinese TrueType Fonts
AddPackage python-colour # Colour representations manipulation library (RGB, HSL, web, ...)
AddPackage sway # Tiling Wayland compositor and replacement for the i3 window manager
AddPackage swayidle # Idle management daemon for Wayland
AddPackage swaylock # Screen locker for Wayland
AddPackage ttf-baekmuk # Korean fonts
AddPackage ttf-droid # General-purpose fonts released by Google as part of Android
AddPackage ttf-liberation # Red Hats Liberation fonts.
AddPackage ttf-linux-libertine # Serif (Libertine) and Sans Serif (Biolinum) OpenType fonts with large Unicode coverage
AddPackage ttf-opensans # Sans-serif typeface commissioned by Google
AddPackage wlroots # Modular Wayland compositor library
AddPackage wl-clipboard # Command-line copy/paste utilities for Wayland
AddPackage x11-ssh-askpass # Lightweight passphrase dialog for SSH
AddPackage xautolock # An automatic X screen-locker/screen-saver
AddPackage xclip # Command line interface to the X11 clipboard
AddPackage xcompmgr # Composite Window-effects manager for X.org
AddPackage xf86-input-libinput # Generic input driver for the X.Org server based on libinput
AddPackage xf86-input-synaptics # Synaptics driver for notebook touchpads
AddPackage xf86-video-intel # X.org Intel i810/i830/i915/945G/G965+ video drivers
AddPackage xorg-server # Xorg X server
AddPackage xorg-twm # Tab Window Manager for the X Window System
AddPackage xorg-xbacklight # RandR-based backlight control application
AddPackage xorg-xdpyinfo # Display information utility for X
AddPackage xorg-xinput # Small commandline tool to configure devices
AddPackage xorg-xinit # X.Org initialisation program
AddPackage xorg-xrandr # Primitive command line interface to RandR extension

AddPackage --foreign i3pystatus # i3status replacement written in python for the i3 window manager
AddPackage --foreign ttf-ms-fonts # Core TTF Fonts from Microsoft
AddPackage --foreign ttf-raleway # An elegant sans-serif font, designed in a single thin weight.
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

CreateLink /etc/fonts/conf.d/10-sub-pixel-rgb.conf ../conf.avail/10-sub-pixel-rgb.conf
