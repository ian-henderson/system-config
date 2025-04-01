;;; Package --- theme.el
;;; Commentary:
;;; Code:

;; https://github.com/kuanyui/moe-theme.el
(use-package moe-theme)

(defvar dark-theme 'moe-dark)
(defvar light-theme 'moe-light)
(defvar current-theme dark-theme)

(defun my-toggle-theme ()
  "Toggle between light and dark themes."
  (interactive)
  (disable-theme current-theme)
  (setq current-theme
	(if (eq current-theme dark-theme) light-theme dark-theme))
  (load-theme current-theme t))

(global-set-key (kbd "<f5>") 'my-toggle-theme)

(defvar calendar-latitude  38.8339)
(defvar calendar-longitude -104.8214)

;; https://github.com/guidoschmidt/circadian.el
(use-package circadian
  :config
  (setq circadian-themes `((:sunrise . ,light-theme)
			   (:sunset  . ,dark-theme)))
  (add-hook 'circadian-after-load-theme-hook
	    (lambda (theme)
	      (setq current-theme theme)))
  (add-hook 'emacs-startup-hook #'circadian-setup)
  (circadian-setup))

(provide 'theme)

;;; theme.el ends here
