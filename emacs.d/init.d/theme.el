;;; Package --- theme.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defun set-theme (theme)
  "Disable all enabled themes and enable THEME."
  (interactive ; Prompts user for a theme
   (list (intern (completing-read "Load theme: " (custom-available-themes)))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t)
  (message "Set theme to '%s'" theme))

;; https://github.com/doomemacs/themes
(use-package doom-themes
  :custom
  (doom-themes-enable-bold nil))

;; https://protesilaos.com/emacs/ef-themes
(use-package ef-themes)

;; https://protesilaos.com/emacs/modus-themes
(use-package modus-themes)

;; https://protesilaos.com/emacs/standard-themes
(use-package standard-themes)

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude    39.530851)
  (calendar-longitude -104.870959)
  (circadian-themes '(("07:30" . doom-xcode)
		      ("18:00" . doom-solarized-dark)))
  :hook
  (emacs-startup . circadian-setup))

(provide 'theme)

;;; theme.el ends here
