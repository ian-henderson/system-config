;;; Package --- windows.el
;;; Commentary:
;;; Code:

;; tabs

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

(dolist (binding '(("M-9" . tab-bar-switch-to-prev-tab)
		   ("M-0" . tab-bar-switch-to-next-tab)
		   ("M-(" . tab-bar-move-tab-backward)
		   ("M-)" . tab-bar-move-tab)
		   ("M-t" . tab-bar-new-tab)
		   ("M-T" . tab-bar-undo-close-tab)
		   ("M-w" . tab-bar-close-tab)))
  (global-set-key (kbd (car binding)) (cdr binding)))

;; maximize, fullscreen
(global-set-key (kbd "C-c f") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-c m") 'toggle-frame-maximized)

;; window resizing keymappings
(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)

;; swap windows
(global-set-key (kbd "C-c s") 'window-swap-states)

;; balance windows
(global-set-key (kbd "C-c =") 'balance-windows)

;; line numbers
(setq-default display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Removes minor modes from modeline after init
(add-hook 'after-init-hook
	  (lambda ()
	    (setq-default mode-line-format
			  (delq 'mode-line-modes mode-line-format))))

;; Removes client side decorations in gnome
(add-to-list 'default-frame-alist '(undecorated . t))

(provide 'windows)

;;; windows.el ends here
