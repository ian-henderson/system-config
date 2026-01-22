;;; Package --- init.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Generate custom.el if one doesn't exist and load it
(setq custom-file (expand-file-name "init.d/custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (with-temp-buffer
    (insert ";;; Package --- custom.el\n")
    (insert ";;; Commentary:\n")
    (insert ";;; Code:\n\n")
    (insert "(provide 'custom)\n\n")
    (insert ";;; custom.el ends here\n")
    (write-region (point-min) (point-max) custom-file)))
(load custom-file)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq-default use-package-always-ensure t)

;; https://gitlab.com/koral/gcmh
(use-package gcmh
  :config
  (gcmh-mode 1)
  :custom
  (garbage-collection-messages t))

(defun global-set-key-list (key-fn-mappings)
  "Set global keybindings.  KEY-FN-MAPPINGS: alist of key and function pairs."
  (dolist (mapping key-fn-mappings)
    (global-set-key (kbd (car mapping)) (cdr mapping))))

;; Loads el files in init.d
;; TODO: skip loading init.d/custom.el since it was loaded earlier in the file
(let ((init-d (expand-file-name "init.d" user-emacs-directory)))
  (when (file-directory-p init-d)
    (mapc #'load-file (directory-files init-d t "\\.el$"))))

(message "Emacs started in %s seconds." (emacs-init-time))

(provide 'init)

;;; init.el ends here
