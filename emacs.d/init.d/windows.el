;;; Package --- windows.el
;;; Commentary:
;;; Code:

(setq tab-bar-close-button-show nil
      tab-bar-format (remove 'tab-bar-format-add-tab tab-bar-format)
      tab-bar-new-tab-choice "*dashboard*")

(tab-bar-mode 1)

(dotimes (i 7) ; Sets M-j to select tab j, where j is in series 1..8 inclusive
  (let ((j (+ i 1)))
    (global-set-key (kbd (format "M-%d" j))
		    (eval `(lambda ()
			     (interactive)
			     (tab-bar-select-tab ,j))))))

(dolist (binding '(("M-9"       . tab-bar-switch-to-prev-tab)
		   ("M-0"       . tab-bar-switch-to-next-tab)
		   ("M-("       . tab-bar-move-tab-backward)
		   ("M-)"       . tab-bar-move-tab)
		   ("M-t"       . tab-bar-new-tab)
		   ("M-T"       . tab-bar-undo-close-tab)
		   ("M-w"       . tab-bar-close-tab)
		   ("C-c f"     . toggle-frame-fullscreen)
		   ("C-c m"     . toggle-frame-maximized)
		   ("C-c s"     . window-swap-states)
		   ("C-c ="     . balance-windows)
		   ("M-<down>"  . shrink-window)
		   ("M-<up>"    . enlarge-window)
		   ("M-<left>"  . shrink-window-horizontally)
		   ("M-<right>" . enlarge-window-horizontally)))
  (global-set-key (kbd (car binding)) (cdr binding)))

;; line numbers
(setq-default display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; removes minor modes from modeline after init
(add-hook 'after-init-hook
	  (lambda ()
	    (setq-default mode-line-format
			  (delq 'mode-line-modes mode-line-format))))

;; removes client-side decorations in GNOME+Linux
(when (and (eq system-type 'gnu/linux)
           (string-match "GNOME" (or (getenv "XDG_CURRENT_DESKTOP") "")))
  (add-to-list 'default-frame-alist '(undecorated . t)))

(provide 'windows)

;;; windows.el ends here
