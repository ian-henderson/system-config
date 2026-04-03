;; This "manifest" file can be passed to 'guix package -m' to reproduce
;; the content of your profile.  This is "symbolic": it only specifies
;; package names.  To reproduce the exact same profile, you also need to
;; capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(specifications->manifest
 (list "quodlibet"
       "signal-desktop"
       "yt-dlp"
       "emacs-pgtk"
       "libreoffice"
       "font-google-noto-emoji"
       "librewolf"
       "cmake"
       "starship"
       "libvterm"
       "lolcat"
       "font-jetbrains-mono"
       "font-hack"
       "bat"
       "gcc-toolchain"
       "make"
       "glib:bin"))
