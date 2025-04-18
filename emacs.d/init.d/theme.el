;;; Package --- theme.el
;;; Commentary:
;;; Code:

;; https://github.com/ianyepan/acme-emacs-theme
(use-package acme-theme :custom (acme-theme-black-fg t))

;; https://protesilaos.com/emacs/modus-themes
(use-package modus-themes
  :custom
  (modus-themes-bold-constructs nil)
  (modus-themes-italic-constructs t))

;; https://protesilaos.com/emacs/standard-themes
(use-package standard-themes)

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes '((:sunrise . acme) (:sunset . modus-vivendi)))
  :hook (emacs-startup . circadian-setup))

(provide 'theme)

;;; theme.el ends here
