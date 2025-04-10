;;; Package --- theme.el
;;; Commentary:
;;; Code:

(defvar theme-dark 'modus-vivendi)
(defvar theme-light 'modus-operandi)

(defun theme-toggle ()
  "Toggle between light and dark themes manually."
  (interactive)
  (let ((theme-current (car custom-enabled-themes)))
    (disable-theme theme-current)
    (load-theme (if (eq theme-current theme-dark) theme-light theme-dark) t)))

(global-set-key (kbd "<f5>") #'theme-toggle)

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes `((:sunrise . ,theme-light)
		      (:sunset  . ,theme-dark)))
  :config
  (circadian-setup))

;; https://github.com/kuanyui/moe-theme.el
(use-package moe-theme)

;; https://protesilaos.com/emacs/modus-themes
(use-package modus-themes
  :custom
  (modus-themes-bold-constructs nil)  ; Enable bold text
  (modus-themes-italic-constructs t)) ; Enable italics

(provide 'theme)

;;; theme.el ends here
