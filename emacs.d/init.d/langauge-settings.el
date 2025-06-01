;;; Package --- langauge-settings.el
;;; Commentary:
;;; Code:

;; c
(add-hook 'c-mode-hook
          (lambda ()
            (setq-default c-basic-offset 4
						  indent-tabs-mode t
                          tab-width 4)))

(provide 'langauge-settings)

;;; langauge-settings.el ends here
