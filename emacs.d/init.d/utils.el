;;; Package --- utils.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "init.el" alist)

(defun open-guix-config ()
  "Open /etc/config.scm."
  (interactive)
  (sudo-edit-find-file "/etc/config.scm"))

;; flyspell
(require 'flyspell)
(dolist (hook '(markdown-mode-hook org-mode-hook text-mode-hook))
  (add-hook hook #'flyspell-mode))

;; info mode buffer title
(add-hook 'Info-selection-hook
          (lambda ()
            (when (and (boundp 'Info-current-file)
                       (stringp Info-current-file))
              (let ((manual (file-name-base Info-current-file))
                    (current-name (buffer-name)))
                (unless (or (string-match-p (regexp-quote manual) current-name)
                            (string-equal manual "dir"))
                  (rename-buffer (format "*info<%s>*" manual) t))))))

(use-package eww
  :ensure
  nil
  :custom
  (eww-auto-rename-buffer
   (lambda ()
     (when (eq major-mode 'eww-mode)
       (when-let ((string (or (plist-get eww-data :title)
                              (plist-get eww-data :url))))
         (if (s-blank-str-p string)
             (format "*eww*")
           (format "*eww<%s>*" string) )))))
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
;; Prevents info mode from being excluded from desktop-save-mode
(remove-hook 'desktop-modes-not-to-save 'Info-mode)

;; Deletes trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Replaces tabs with spaces
(setq-default indent-tabs-mode nil)

(defun untabify-buffer ()
  "Untabify entire buffer."
  (interactive)
  (save-excursion
    (untabify (point-min) (point-max)))
  (message "Untabified buffer: %s" (buffer-name)))

(set-frame-parameter nil 'alpha-background 100)

;; Backup config
(let ((backups (expand-file-name "backups" user-emacs-directory)))
  (if (not (file-directory-p backups))
      (mkdir backups))
  (setq backup-directory-alist `(("." . ,backups))
        make-backup-files t)) ; t by default

;; turns off prompt checking if active processes should be closed
(setq confirm-kill-processes nil)

;; confirm when quitting emacs
(setq confirm-kill-emacs 'yes-or-no-p)

(provide 'utils)

;;; utils.el ends here
