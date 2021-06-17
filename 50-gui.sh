AddPackage gnu-free-fonts # A free family of scalable outline fonts
AddPackage grim # Screenshot utility for Wayland
AddPackage gtk3-demos # GObject-based multi-platform GUI toolkit (demo applications)
AddPackage gtk4 # GObject-based multi-platform GUI toolkit
AddPackage gtk4-demos # GObject-based multi-platform GUI toolkit (demo applications)
AddPackage i3-wm # An improved dynamic tiling window manager
AddPackage i3blocks # Define blocks for your i3bar status line
AddPackage i3lock # An improved screenlocker based upon XCB and PAM
AddPackage i3status # Generates status bar to use with i3bar, dzen2 or xmobar
AddPackage ly # TUI display manager
AddPackage mako # Lightweight notification daemon for Wayland
AddPackage opendesktop-fonts # Chinese TrueType Fonts
AddPackage otf-font-awesome # Iconic font designed for Bootstrap
AddPackage picom # X compositor that may fix tearing issues
AddPackage py3status # An extensible i3status replacement/wrapper written in python
AddPackage python-basiciw # Retrieve information such as ESSID or signal quality from wireless cards (Python module)
AddPackage python-colour # Colour representations manipulation library (RGB, HSL, web, ...)
AddPackage qt5-script # Classes for making Qt applications scriptable. Provided for Qt 4.x compatibility
AddPackage qt5-tools # A cross-platform application and UI framework (Development Tools, QtHelp)
AddPackage sway # Tiling Wayland compositor and replacement for the i3 window manager
AddPackage swayidle # Idle management daemon for Wayland
AddPackage swaylock # Screen locker for Wayland
AddPackage terminus-font # Monospace bitmap font (for X11 and console)
AddPackage ttf-baekmuk # Korean fonts
AddPackage ttf-bitstream-vera # Bitstream Vera fonts.
AddPackage ttf-dejavu # Font family based on the Bitstream Vera Fonts with a wider range of characters
AddPackage ttf-fira-code # Monospaced font with programming ligatures
AddPackage ttf-liberation # Red Hats Liberation fonts.
AddPackage ttf-linux-libertine # Serif (Libertine) and Sans Serif (Biolinum) OpenType fonts with large Unicode coverage
AddPackage ttf-linux-libertine-g # Graphite port of Linux Libertine and Linux Biolinum fonts
AddPackage ttf-ms-fonts # Core TTF Fonts from Microsoft
AddPackage ttf-opensans # Sans-serif typeface commissioned by Google
AddPackage waybar # Highly customizable Wayland bar for Sway and Wlroots based compositors
AddPackage wl-clipboard # Command-line copy/paste utilities for Wayland
AddPackage xautolock # An automatic X screen-locker/screen-saver
AddPackage xboard # Graphical user interfaces for chess
AddPackage xf86-video-intel # X.org Intel i810/i830/i915/945G/G965+ video drivers
AddPackage xkb-switch # Program that allows to query and change the XKB layout state
AddPackage xorg-server # Xorg X server
AddPackage xorg-server-xephyr # A nested X server that runs as an X application
AddPackage xorg-xdpyinfo # Display information utility for X
AddPackage xorg-xinput # Small commandline tool to configure devices
AddPackage xorg-xrandr # Primitive command line interface to RandR extension
AddPackage xorg-xrdb # X server resource database utility
AddPackage xorg-xwayland # run X clients under wayland
AddPackage zenity # Display graphical dialog boxes from shell scripts

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

CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/ly.service

CreateLink /etc/fonts/conf.d/10-hinting-full.conf /etc/fonts/conf.avail/10-hinting-full.conf
CreateLink /etc/fonts/conf.d/10-hinting-slight.conf /usr/share/fontconfig/conf.default/10-hinting-slight.conf
CreateLink /etc/fonts/conf.d/10-scale-bitmap-fonts.conf /usr/share/fontconfig/conf.default/10-scale-bitmap-fonts.conf
CreateLink /etc/fonts/conf.d/20-unhint-small-dejavu-lgc-sans-mono.conf /usr/share/fontconfig/conf.default/20-unhint-small-dejavu-lgc-sans-mono.conf
CreateLink /etc/fonts/conf.d/20-unhint-small-dejavu-lgc-sans.conf /usr/share/fontconfig/conf.default/20-unhint-small-dejavu-lgc-sans.conf
CreateLink /etc/fonts/conf.d/20-unhint-small-dejavu-lgc-serif.conf /usr/share/fontconfig/conf.default/20-unhint-small-dejavu-lgc-serif.conf
CreateLink /etc/fonts/conf.d/20-unhint-small-dejavu-sans-mono.conf /usr/share/fontconfig/conf.default/20-unhint-small-dejavu-sans-mono.conf
CreateLink /etc/fonts/conf.d/20-unhint-small-dejavu-sans.conf /usr/share/fontconfig/conf.default/20-unhint-small-dejavu-sans.conf
CreateLink /etc/fonts/conf.d/20-unhint-small-dejavu-serif.conf /usr/share/fontconfig/conf.default/20-unhint-small-dejavu-serif.conf
CreateLink /etc/fonts/conf.d/20-unhint-small-vera.conf /usr/share/fontconfig/conf.default/20-unhint-small-vera.conf
CreateLink /etc/fonts/conf.d/30-metric-aliases.conf /usr/share/fontconfig/conf.default/30-metric-aliases.conf
CreateLink /etc/fonts/conf.d/40-nonlatin.conf /usr/share/fontconfig/conf.default/40-nonlatin.conf
CreateLink /etc/fonts/conf.d/45-generic.conf /usr/share/fontconfig/conf.default/45-generic.conf
CreateLink /etc/fonts/conf.d/45-latin.conf /usr/share/fontconfig/conf.default/45-latin.conf
CreateLink /etc/fonts/conf.d/49-sansserif.conf /usr/share/fontconfig/conf.default/49-sansserif.conf
CreateLink /etc/fonts/conf.d/50-user.conf /usr/share/fontconfig/conf.default/50-user.conf
CreateLink /etc/fonts/conf.d/51-local.conf /usr/share/fontconfig/conf.default/51-local.conf
CreateLink /etc/fonts/conf.d/57-dejavu-sans-mono.conf /usr/share/fontconfig/conf.default/57-dejavu-sans-mono.conf
CreateLink /etc/fonts/conf.d/57-dejavu-sans.conf /usr/share/fontconfig/conf.default/57-dejavu-sans.conf
CreateLink /etc/fonts/conf.d/57-dejavu-serif.conf /usr/share/fontconfig/conf.default/57-dejavu-serif.conf
CreateLink /etc/fonts/conf.d/58-dejavu-lgc-sans-mono.conf /usr/share/fontconfig/conf.default/58-dejavu-lgc-sans-mono.conf
CreateLink /etc/fonts/conf.d/58-dejavu-lgc-sans.conf /usr/share/fontconfig/conf.default/58-dejavu-lgc-sans.conf
CreateLink /etc/fonts/conf.d/58-dejavu-lgc-serif.conf /usr/share/fontconfig/conf.default/58-dejavu-lgc-serif.conf
CreateLink /etc/fonts/conf.d/60-generic.conf /usr/share/fontconfig/conf.default/60-generic.conf
CreateLink /etc/fonts/conf.d/60-latin.conf /usr/share/fontconfig/conf.default/60-latin.conf
CreateLink /etc/fonts/conf.d/65-fonts-persian.conf /usr/share/fontconfig/conf.default/65-fonts-persian.conf
CreateLink /etc/fonts/conf.d/65-nonlatin.conf /usr/share/fontconfig/conf.default/65-nonlatin.conf
CreateLink /etc/fonts/conf.d/69-unifont.conf /usr/share/fontconfig/conf.default/69-unifont.conf
CreateLink /etc/fonts/conf.d/69-urw-bookman.conf /usr/share/fontconfig/conf.default/69-urw-bookman.conf
CreateLink /etc/fonts/conf.d/69-urw-c059.conf /usr/share/fontconfig/conf.default/69-urw-c059.conf
CreateLink /etc/fonts/conf.d/69-urw-d050000l.conf /usr/share/fontconfig/conf.default/69-urw-d050000l.conf
CreateLink /etc/fonts/conf.d/69-urw-fallback-backwards.conf /usr/share/fontconfig/conf.default/69-urw-fallback-backwards.conf
CreateLink /etc/fonts/conf.d/69-urw-fallback-generics.conf /usr/share/fontconfig/conf.default/69-urw-fallback-generics.conf
CreateLink /etc/fonts/conf.d/69-urw-fallback-specifics.conf /usr/share/fontconfig/conf.default/69-urw-fallback-specifics.conf
CreateLink /etc/fonts/conf.d/69-urw-gothic.conf /usr/share/fontconfig/conf.default/69-urw-gothic.conf
CreateLink /etc/fonts/conf.d/69-urw-nimbus-mono-ps.conf /usr/share/fontconfig/conf.default/69-urw-nimbus-mono-ps.conf
CreateLink /etc/fonts/conf.d/69-urw-nimbus-roman.conf /usr/share/fontconfig/conf.default/69-urw-nimbus-roman.conf
CreateLink /etc/fonts/conf.d/69-urw-nimbus-sans.conf /usr/share/fontconfig/conf.default/69-urw-nimbus-sans.conf
CreateLink /etc/fonts/conf.d/69-urw-p052.conf /usr/share/fontconfig/conf.default/69-urw-p052.conf
CreateLink /etc/fonts/conf.d/69-urw-standard-symbols-ps.conf /usr/share/fontconfig/conf.default/69-urw-standard-symbols-ps.conf
CreateLink /etc/fonts/conf.d/69-urw-z003.conf /usr/share/fontconfig/conf.default/69-urw-z003.conf
CreateLink /etc/fonts/conf.d/70-no-bitmaps.conf /etc/fonts/conf.avail/70-no-bitmaps.conf
CreateLink /etc/fonts/conf.d/75-yes-terminus.conf /usr/share/fontconfig/conf.default/75-yes-terminus.conf
CreateLink /etc/fonts/conf.d/80-delicious.conf /usr/share/fontconfig/conf.default/80-delicious.conf
CreateLink /etc/fonts/conf.d/90-synthetic.conf /usr/share/fontconfig/conf.default/90-synthetic.conf
