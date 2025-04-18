;;; Package --- windows.el
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "early-init.el" cons-list)

(defvar windows-keybindings-list
  '(("C-c f"     . toggle-frame-fullscreen)
    ("C-c m"     . toggle-frame-maximized)
    ("C-c s"     . window-swap-states)
    ("C-c ="     . balance-windows)
    ("M-<down>"  . shrink-window)
    ("M-<up>"    . enlarge-window)
    ("M-<left>"  . shrink-window-horizontally)
    ("M-<right>" . enlarge-window-horizontally)))

(global-set-key-list windows-keybindings-list)

(column-number-mode 1)
(electric-pair-mode 1)
(global-visual-line-mode 1)
(which-key-mode 1)

;; line numbers and fill-column
(setq-default display-line-numbers-type 'relative
	      fill-column 80)
(dolist (hook '(conf-toml-mode-hook prog-mode-hook))
  (add-hook hook #'display-line-numbers-mode)
  (add-hook hook #'display-fill-column-indicator-mode))

;; prettify symbols
(dolist (hook '(emacs-lisp-mode-hook scheme-mode-hook))
  (add-hook hook #'prettify-symbols-mode))

(defun remove-mode-line-modes-from-mode-line ()
  "Remove modes from modeline."
  (setq mode-line-format
	(delq 'mode-line-modes mode-line-format)))
(add-hook 'after-init-hook #'remove-mode-line-modes-from-mode-line)

;; tab size for shell mode
(add-hook 'sh-mode-hook (lambda () (setq-local tab-width 4)))

(provide 'windows)

;;; windows.el ends here
