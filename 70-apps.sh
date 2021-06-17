AddPackage aisleriot # A collection of patience games written in guile scheme
AddPackage alacritty # A cross-platform, GPU-accelerated terminal emulator
AddPackage alsa-plugins # Additional ALSA plugins
AddPackage alsa-utils # Advanced Linux Sound Architecture - Utilities
AddPackage android-tools # Android platform tools
AddPackage anki # Helps you remember facts (like words/phrases in a foreign language) efficiently
AddPackage arch-install-scripts # Scripts to aid in installing Arch Linux
AddPackage asciinema # Record and share terminal sessions
AddPackage asp # Arch Linux build source file management tool
AddPackage baobab # A graphical directory tree analyzer
AddPackage bash-language-server # Bash language server implementation based on Tree Sitter and its grammar for Bash
AddPackage bashdb # A debugger for Bash scripts loosely modeled on the gdb command syntax
AddPackage bc # An arbitrary precision calculator language
AddPackage bindfs # A FUSE filesystem for mirroring a directory to another directory, similar to 'mount --bind', with permission settings.
AddPackage binfmt-qemu-static # Register qemu-static interpreters for various binary formats
AddPackage bluez # Daemons for the bluetooth protocol stack
AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack
AddPackage brillo # Control the brightness of backlight and keyboard LED devices
AddPackage chromium # A web browser built for speed, simplicity, and security
AddPackage encfs # Encrypted filesystem in user-space
AddPackage evince # Document viewer (PDF, Postscript, djvu, tiff, dvi, XPS, SyncTex support with gedit, comics books (cbr,cbz,cb7 and cbt))
AddPackage firefox # Standalone web browser from mozilla.org
AddPackage fzf # Command-line fuzzy finder
AddPackage gimp-git # GNU Image Manipulation Program
AddPackage glade # User Interface Builder for GTK+ applications
AddPackage gnome-chess # Play the classic two-player boardgame of chess
AddPackage gnome-font-viewer # A font viewer utility for GNOME
AddPackage gnome-keyring # Stores passwords and encryption keys
AddPackage gnome-mines # Clear hidden mines from a minefield
AddPackage gnome-terminal # The GNOME Terminal Emulator
AddPackage gnubg # World class backgammon application
AddPackage gnuchess # Play chess against the computer on a terminal and an engine for graphical chess frontends
AddPackage gst-libav # GStreamer Multimedia Framework ffmpeg Plugin
AddPackage gst-plugins-good # GStreamer Multimedia Framework Good Plugins
AddPackage gst-plugins-ugly # GStreamer Multimedia Framework Ugly Plugins
AddPackage gstreamer-vaapi # GStreamer Multimedia Framework VAAPI Plugin
AddPackage imv # Image viewer for Wayland and X11
AddPackage inkscape # Professional vector graphics editor
AddPackage ledger # Double-entry accounting system with a command-line reporting interface
AddPackage lldb # Next generation, high-performance debugger
AddPackage lynx # A text browser for the World Wide Web
AddPackage make # GNU make utility to maintain groups of programs
AddPackage man-db # A utility for reading man pages
AddPackage man-pages # Linux man pages
AddPackage mc # Midnight Commander is a text based filemanager/shell that emulates Norton Commander
AddPackage mediainfo # supplies technical and tag information about a video or audio file
AddPackage mesa-demos # Mesa demos and tools incl. glxinfo + glxgears
AddPackage minicom # A serial communication program
AddPackage mpv # a free, open source, and cross-platform media player
AddPackage neofetch # A CLI system information tool written in BASH that supports displaying images.
AddPackage neovim # Fork of Vim aiming to improve user experience, plugins, and GUIs
AddPackage nmap # Utility for network discovery and security auditing
AddPackage openscad # The programmers solid 3D CAD modeller
AddPackage pass # Stores, retrieves, generates, and synchronizes passwords securely
AddPackage pavucontrol # PulseAudio Volume Control
AddPackage pulseaudio # A featureful, general-purpose sound server
AddPackage python-pynvim # Python client for Neovim
AddPackage python-pytest # Simple powerful testing with Python
AddPackage qemu-user-static-bin # A generic and open source machine emulator, statically linked
AddPackage qt5-wayland # Provides APIs for Wayland
AddPackage remmina # remote desktop client written in GTK+
AddPackage ripgrep # A search tool that combines the usability of ag with the raw speed of grep
AddPackage seahorse # GNOME application for managing PGP keys.
AddPackage shotwell # A digital photo organizer designed for the GNOME desktop environment
AddPackage speedtest-cli # Command line interface for testing internet bandwidth using speedtest.net
AddPackage sshuttle # Transparent proxy server that forwards all TCP packets over ssh
AddPackage strace # A diagnostic, debugging and instructional userspace tracer
AddPackage transmission-cli # Fast, easy, and free BitTorrent client (CLI tools, daemon and web client)
AddPackage udiskie # Removable disk automounter using udisks
AddPackage vlc # Multi-platform MPEG, VCD/DVD, and DivX player
AddPackage w3m # Text-based Web browser as well as pager
AddPackage wireshark-qt # Network traffic and protocol analyzer/sniffer - Qt GUI
AddPackage wpa_supplicant # A utility providing key negotiation for WPA wireless networks
AddPackage x2goclient # a graphical client (Qt4) for the X2Go system
AddPackage youtube-dl # A small command-line program to download videos from YouTube.com and a few more sites


cat >"$(CreateFile /etc/mpv/mpv.conf)" <<EOF
ytdl-format=bestvideo[height<=1080][ext=mp4]+bestaudio/bestvideo[height<=1080]+bestaudio/best
sub-auto=fuzzy
hwdec=auto
gpu-context=wayland
EOF

CopyFile /etc/minirc.dfl
