(use-modules (gnu home)
             (gnu home services)
             (gnu home services desktop)
             (gnu home services sound)
             (gnu packages))

(home-environment
 (packages (specifications->packages
            (list "bat"
                  "clang"
                  "cmake"
                  "emacs-pgtk"
                  "font-google-noto-emoji"
                  "font-hack"
                  "font-jetbrains-mono"
                  "gcc-toolchain"
                  "libreoffice"
                  "librewolf"
                  "libvterm"
                  "lolcat"
                  "make"
                  "quodlibet"
                  "shfmt"
                  "signal-desktop"
                  "starship"
                  "yt-dlp")))
 (services (list (service home-dbus-service-type)
                 (service home-pipewire-service-type
                          (home-pipewire-configuration
                           (enable-pulseaudio? #t))))))
