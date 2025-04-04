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

(use-package moe-theme
  :defer t)

;; https://protesilaos.com/emacs/modus-themes
(use-package modus-themes
  :custom
  (modus-themes-bold-constructs t)    ;; Enable bold text
  (modus-themes-italic-constructs t)) ;; Enable italics

(use-package circadian
  :after modus-themes
  :custom ; values are evaluated as literals, hence the ` and , chars
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes `((:sunrise . ,theme-light)
		      (:sunset  . ,theme-dark)))
  :config
  (circadian-setup))

(provide 'theme)

;;; theme.el ends here
