;;; Package --- windows.el
;;; Commentary:
;;; Code:

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

;; line numbers
(setq-default display-line-numbers-type 'relative)
(dolist (hook '(conf-toml-mode-hook prog-mode-hook))
  (add-hook hook #'display-line-numbers-mode))

;; prettify symbols
;; Going to explicitly list which modes. The default ligatures look terrible.
(mapc (lambda (hook)
	(add-hook hook #'prettify-symbols-mode))
      '(emacs-lisp-mode-hook scheme-mode-hook))

(defun remove-mode-line-modes-from-mode-line ()
  "Remove modes from modeline."
  (setq mode-line-format
	(delq 'mode-line-modes mode-line-format)))
(add-hook 'after-init-hook #'remove-mode-line-modes-from-mode-line)

;; tab size for shell mode
(add-hook 'sh-mode-hook (lambda () (setq-local tab-width 4)))

(provide 'windows)

;;; windows.el ends here
