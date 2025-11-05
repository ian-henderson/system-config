;;; Package --- theme.el
;;; Commentary:
;;; Code:

(defun set-theme (theme)
  "Disable all enabled themes and enable THEME."
  (interactive ; Prompts user for a theme
   (list (intern (completing-read "Load theme: " (custom-available-themes)))))
  (mapc (lambda (theme) (disable-theme theme)) custom-enabled-themes)
  (load-theme theme t)
  (message "Set theme to '%s" theme))

;; https://protesilaos.com/emacs/ef-themes-pictures
(use-package ef-themes)

;; https://protesilaos.com/emacs/modus-themes-pictures
(use-package modus-themes)

;; https://protesilaos.com/emacs/standard-themes-pictures
(use-package standard-themes)

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes '((:sunrise . ef-light) (:sunset . ef-dark)))
  :hook (emacs-startup . circadian-setup))

(provide 'theme)

;;; theme.el ends here
