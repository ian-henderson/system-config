(use-modules (gnu home)
             (gnu home services)
             (gnu home services desktop)
             (gnu home services sound)
             (gnu packages))

(define %my-packages
  '("adwaita-icon-theme"
    "bat"
    "bibata-cursor-theme"
    "btop"
    "cmake"
    "fastfetch"
    "font-anonymous-pro"
    "font-google-noto"
    "font-google-noto-emoji"
    "font-google-noto-sans-cjk"
    "font-hack"
    "font-jetbrains-mono"
    "font-liberation"
    "font-microsoft-cascadia"
    "gcc-toolchain"
    "gnome-shell-extension-blur-my-shell"
    "gnome-shell-extension-just-perfection"
    "gnome-shell-extension-night-theme-switcher"
    "gnome-tweaks"
    "ispell"
    "jpegoptim"
    "libreoffice"
    "librewolf"
    "libvterm"
    "lolcat"
    "make"
    "pngquant"
    "quodlibet"
    "shfmt"
    "signal-desktop"
    "starship"
    "tree"
    "vscodium"
    "yt-dlp"))

(define %my-emacs-packages
  '("emacs-aggressive-indent"
    "emacs-avy"
    "emacs-circadian"
    "emacs-company"
    "emacs-dashboard"
    "emacs-doom-themes"
    "emacs-ef-themes"
    "emacs-eglot"
    "emacs-elfeed"
    "emacs-emms"
    "emacs-erc-hl-nicks"
    "emacs-exec-path-from-shell"
    "emacs-f"
    "emacs-flycheck"
    "emacs-format-all-the-code"
    "emacs-gcmh"
    "emacs-geiser"
    "emacs-geiser-guile"
    "emacs-git-gutter-fringe"
    "emacs-guix"
    "emacs-json-mode"
    "emacs-lua-mode"
    "emacs-magit"
    "emacs-marginalia"
    "emacs-markdown-mode"
    "emacs-minions"
    "emacs-modus-themes"
    "emacs-orderless"
    "emacs-org-bullets"
    "emacs-paredit"
    "emacs-pgtk"
    "emacs-php-mode"
    "emacs-projectile"
    "emacs-rainbow-delimiters"
    "emacs-rust-mode"
    "emacs-s"
    "emacs-standard-themes"
    "emacs-sudo-edit"
    "emacs-typescript-mode"
    "emacs-vertico"
    "emacs-visual-fill-column"
    "emacs-vterm"
    "emacs-web-mode"
    "emacs-yaml-mode"))

(home-environment
  (packages (specifications->packages (append %my-packages %my-emacs-packages)))
  (services (list (service home-dbus-service-type)
                  (service home-pipewire-service-type
                           (home-pipewire-configuration
                             (enable-pulseaudio? #t))))))
