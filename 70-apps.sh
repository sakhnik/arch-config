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
AddPackage --foreign gpwsafe # A commandline program for managing encrypted password databases
AddPackage --foreign ledger # Double-entry accounting system with a command-line reporting interface
AddPackage --foreign libcatch-cpp-headers # C++-native framework for unit-tests using only a header file
AddPackage --foreign neovim-git # Fork of Vim aiming to improve user experience, plugins, and GUIs.
AddPackage --foreign pamtester # Tiny program to test the pluggable authentication modules (PAM) facility
AddPackage --foreign peerflix # Streaming torrent client for node.js
AddPackage --foreign pkgbuild-introspection # Tools for generating .AURINFO files and PKGBUILD data extraction
AddPackage --foreign python-neovim-git # Python client to neovim, git version. Use this to keep up with neovim-git
AddPackage --foreign python2-neovim-git # Python client to neovim, git version. Use this to keep up with neovim-git
AddPackage --foreign qemu-user-static # A generic and open source processor emulator which achieves a good emulation speed by using dynamic translation, statically linked.
AddPackage --foreign realvnc-vnc-viewer # VNC remote desktop client software by RealVNC
AddPackage --foreign rtags-git # RTags is a client/server application that indexes C/C++ code.
AddPackage --foreign tor-browser-en # Tor Browser Bundle
AddPackage --foreign ttf-opensans # Sans-serif typeface commissioned by Google
AddPackage --foreign ttf-raleway # An elegant sans-serif font, designed in a single thin weight.
AddPackage --foreign universal-ctags-git # Multilanguage reimplementation of the Unix ctags utility
AddPackage --foreign wpa_supplicant_gui # A Qt frontend to wpa_supplicant

CreateLink /etc/mc/mc.keymap mc.default.keymap
SetFileProperty /etc/mc/mc.keymap mode 777

cat >"$(CreateFile /etc/mpv/mpv.conf)" <<EOF
hwdec=vaapi
#vo=opengl
#opengl-backend=wayland
vo=vaapi
EOF
