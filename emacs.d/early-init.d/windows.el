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

;; line numbers
(setq-default display-line-numbers-type 'relative)
(dolist (hook '(conf-toml-mode-hook prog-mode-hook))
  (add-hook hook #'display-line-numbers-mode))

(defun remove-mode-line-modes-from-mode-line ()
  "Remove modes from modeline."
  (setq mode-line-format
	(delq 'mode-line-modes mode-line-format)))
(add-hook 'after-init-hook #'remove-mode-line-modes-from-mode-line)

(provide 'windows)

;;; windows.el ends here
