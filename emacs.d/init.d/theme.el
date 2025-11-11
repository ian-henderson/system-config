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

;; https://github.com/doomemacs/themes
(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t))

;; https://protesilaos.com/emacs/ef-themes-pictures
(use-package ef-themes)

;; https://github.com/maio/eink-emacs
(use-package eink-theme)

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes '((:sunrise . eink)
 		      ("15:00"  . doom-xcode)
 		      (:sunset  . doom-1337)))
  :hook (emacs-startup . circadian-setup))

(provide 'theme)

;;; theme.el ends here
