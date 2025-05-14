;;; Package --- langauge-settings.el
;;; Commentary:
;;; Code:

;; c
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-set-style "k&r")
	    (setq c-basic-offset 4
		  indent-tabs-mode nil)))

(provide 'langauge-settings)

;;; langauge-settings.el ends here
