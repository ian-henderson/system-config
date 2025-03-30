;;; Package --- windows.el
;;; Commentary:
;;; Code:

;; fullscreen/maximize keybindings
(defun my-maximize-on-new-frame (frame)
  "Make the new FRAME fullscreen."
  (with-selected-frame frame
    (toggle-frame-maximized)))

;; maximize on start
;; (add-hook 'after-make-frame-functions 'my-maximize-on-new-frame)
;; (add-hook 'window-setup-hook 'toggle-frame-maximized t)

(global-set-key (kbd "C-c f") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-c m") 'toggle-frame-maximized)

;; Moves cursor across panes
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-l") 'windmove-right)

;; window resizing keymappings
(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-0") 'balance-windows)

;; swap windows
(global-set-key (kbd "C-c s") 'window-swap-states)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; line numbers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(defvar display-line-numbers-exempt-modes
  '(Buffer-menu-mode
    dired-mode
    ert-results-mode
    eshell-mode
    eww-bookmark-mode
    eww-mode
    help-mode
    Info-mode
    messages-buffer-mode
    neotree-mode
    rcirc-mode
    shell-mode
    term-mode
    vterm-mode))

(defun display-line-numbers--turn-off-in-exempt-modes ()
  "Turn off line numbers in modes defined in `display-line-numbers-exempt-modes`."
  (when (member major-mode display-line-numbers-exempt-modes)
    (display-line-numbers-mode 0)))

(dolist (mode display-line-numbers-exempt-modes)
  (let ((hook (intern (concat (symbol-name mode) "-hook"))))
    (add-hook hook #'display-line-numbers--turn-off-in-exempt-modes)))

;; Turn off line numbers immediately in existing buffers of exempt modes
(dolist (buffer (buffer-list))
  (with-current-buffer buffer
    (display-line-numbers--turn-off-in-exempt-modes)))

;; Removes minor modes from modeline after init
(add-hook 'after-init-hook
	  (lambda ()
	    (setq-default mode-line-format
			  (delq 'mode-line-modes mode-line-format))))

(provide 'windows)
;;; windows.el ends here
