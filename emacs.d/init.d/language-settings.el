;;; Package --- language-settings.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; C/C++
(dolist (hook '(c-mode-hook c++-mode-hook))
  (add-hook hook (lambda () (setq-local c-basic-offset 4))))

;; Java
(add-hook 'java-mode-hook (lambda () (setq-local indent-tabs-mode nil
					    tab-width 4)))

;;; language-settings.el ends here
