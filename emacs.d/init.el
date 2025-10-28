;;; Package --- init.el
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
  :custom (garbage-collection-messages t)
  :config (gcmh-mode 1))

(defun global-set-key-list (alist)
  "Set global keybindings.  ALIST: list of key and function pairs."
  (dolist (pair alist)
    (global-set-key (kbd (car pair)) (cdr pair))))

;; Loads el files in init.d
(let ((init-d (expand-file-name "init.d" user-emacs-directory)))
  (when (file-directory-p init-d)
    (mapc #'load-file (directory-files init-d t "\\.el$"))))

(message "Emacs started in %s seconds." (emacs-init-time))

(provide 'init)

;;; init.el ends here
