;;; Package --- language-settings.el
;;; Commentary:
;;; Code:

(add-hook 'c-mode-hook (lambda ()
			 (setq c-basic-offset 4)))

(add-hook 'c++-mode-hook (lambda ()
			   (setq c-basic-offset 4)))

;;; language-settings.el ends here
