AddPackage gnu-free-fonts # A free family of scalable outline fonts
AddPackage i3-wm # An improved dynamic tiling window manager
AddPackage i3blocks # Define blocks for your i3bar status line
AddPackage i3lock # An improved screenlocker based upon XCB and PAM
AddPackage i3status # Generates status bar to use with i3bar, dzen2 or xmobar
AddPackage opendesktop-fonts # Chinese TrueType Fonts
AddPackage picom # X compositor that may fix tearing issues
AddPackage python-basiciw # Retrieve information such as ESSID or signal quality from wireless cards (Python module)
AddPackage python-colour # Colour representations manipulation library (RGB, HSL, web, ...)
AddPackage qt5-script # Classes for making Qt applications scriptable. Provided for Qt 4.x compatibility
AddPackage qt5-tools # A cross-platform application and UI framework (Development Tools, QtHelp)
AddPackage sway # Tiling Wayland compositor and replacement for the i3 window manager
AddPackage swayidle # Idle management daemon for Wayland
AddPackage swaylock # Screen locker for Wayland
AddPackage ttf-baekmuk # Korean fonts
AddPackage ttf-liberation # Red Hats Liberation fonts.
AddPackage ttf-linux-libertine # Serif (Libertine) and Sans Serif (Biolinum) OpenType fonts with large Unicode coverage
AddPackage ttf-ms-fonts # Core TTF Fonts from Microsoft
AddPackage ttf-opensans # Sans-serif typeface commissioned by Google
AddPackage wl-clipboard # Command-line copy/paste utilities for Wayland
AddPackage xautolock # An automatic X screen-locker/screen-saver
AddPackage xf86-video-intel # X.org Intel i810/i830/i915/945G/G965+ video drivers
AddPackage xkb-switch # Program that allows to query and change the XKB layout state
AddPackage xorg-server # Xorg X server
AddPackage xorg-xdpyinfo # Display information utility for X
AddPackage xorg-xinput # Small commandline tool to configure devices
AddPackage xorg-xrandr # Primitive command line interface to RandR extension

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
