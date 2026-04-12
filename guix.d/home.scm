(use-modules (gnu home)
             (gnu home services)
             (gnu home services desktop)
             (gnu home services sound)
             (gnu packages))

(home-environment
  (packages (specifications->packages
             (list "bat"
                   "cmake"
                   "emacs-pgtk"
                   "font-anonymous-pro"
                   "font-google-noto"
                   "font-google-noto-emoji"
                   "font-google-noto-sans-cjk"
                   "font-google-roboto"
                   "font-google-roboto-mono"
                   "font-hack"
                   "font-jetbrains-mono"
                   "font-liberation"
                   "font-microsoft-cascadia"
                   "gcc-toolchain"
                   "ispell"
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
