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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("465345d03688959882820007491df63856afccca64c6ed19dfb781a95c6cf724"
     "8717434774f34f325aca6fedb24b572026a0e61dca6e3fe5c03f8c3af8f412f6" default))
 '(git-gutter:hide-gutter t)
 '(git-gutter:update-interval 2)
 '(package-selected-packages
   '(aggressive-indent auto-package-update circadian company dashboard
		       evil-collection evil-surround exec-path-from-shell
		       fish-mode flycheck format-all gcmh git-gutter
		       golden-ratio json-mode magit marginalia markdown-mode
		       modus-themes orderless org-bullets projectile
		       rainbow-delimiters rust-mode standard-themes systemd
		       vertico vterm yaml-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
