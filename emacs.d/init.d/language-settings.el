;;; Package --- language-settings.el
;;; Commentary:
;;; Code:

(add-hook 'c-mode-hook (lambda ()
			 (setq-local c-basic-offset 4)))

(add-hook 'c++-mode-hook (lambda ()
			   (setq-local c-basic-offset 4)))

(add-hook 'java-mode-hook (lambda ()
			    (setq-local indent-tabs-mode nil
					tab-width 4)))

;;; language-settings.el ends here
