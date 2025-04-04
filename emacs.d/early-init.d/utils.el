;;; Package --- utils.el
;;; Commentary:
;;; Code:

(defvar utils-keybindings-list
  '(("C-c c" . clipboard-kill-ring-save)
    ("C-c v" . clipboard-yank)
    ("C-c x" . clipboard-kill-region)
    ("C-c i" . rcirc)
    ("C-c u" . browse-url-at-point)))

(global-set-key-list utils-keybindings-list)

;; desktop-save-mode
(desktop-save-mode 1)
(setq-default desktop-lazy-verbose t
              desktop-load-locked-desktop t
              desktop-save t)

;; Turns off bell
(setq-default ring-bell-function 'ignore)

;; Deletes trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Case-insensitive completion
(setq-default completion-ignore-case t
              read-buffer-completion-ignore-case t
              read-file-name-completion-ignore-case t)

(provide 'utils)

;;; utils.el ends here
