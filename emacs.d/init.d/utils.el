;;; Package --- utils.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "init.el" alist)

;; flyspell
(require 'flyspell)
(dolist (hook '(markdown-mode-hook org-mode-hook text-mode-hook))
  (add-hook hook #'flyspell-mode))

(use-package eww
  :ensure nil
  :custom
  (eww-search-prefix "https://lite.duckduckgo.com/lite?q=")
  (shr-width nil))

(savehist-mode t)

(global-set-key-list '(("C-c u" . browse-url-at-point)
		       ("C-c c" . clipboard-kill-ring-save)
		       ("C-c v" . clipboard-yank)
		       ("C-c x" . clipboard-kill-region)))

;; desktop save mode
(desktop-save-mode 1)
(setq-default desktop-load-locked-desktop t)

;; Deletes trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(set-frame-parameter nil 'alpha-background 100)

;; Backup config
(let ((backups (expand-file-name "backups" user-emacs-directory)))
  (if (not (file-directory-p backups))
      (mkdir backups))
  (setq backup-directory-alist `(("." . ,backups))
	make-backup-files t)) ; t by default

(provide 'utils)

;;; utils.el ends here
