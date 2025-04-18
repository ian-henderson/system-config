;;; Package --- init.el
;;; Commentary:
;;; Code:

;; MELPA (Milkypostman's Emacs Lisp Package Archive)
;; https://melpa.org
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstraps MELPA use-package if not installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq-default use-package-always-ensure t)

;; https://gitlab.com/koral/gcmh
(use-package gcmh
  :custom (garbage-collection-messages t)
  :config (gcmh-mode 1))

;; Loads el files in init.d
(let ((init-d (expand-file-name "init.d" user-emacs-directory)))
  (when (file-directory-p init-d)
    (mapc #'load-file (directory-files init-d t "\\.el$"))))

(message "Emacs started in %s seconds." (emacs-init-time))

(provide 'init)

;;; init.el ends here
