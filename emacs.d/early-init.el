;;; Package --- early-init.el
;;; Commentary:
;;; Code:

(defun global-set-key-list (alist)
  "Set global keybindings.  ALIST: list of key and function pairs."
  (dolist (pair alist)
    (global-set-key (kbd (car pair)) (cdr pair))))

(prefer-coding-system 'utf-8)

(display-battery-mode 1)
(display-time-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq-default coding-system-for-read 'utf-8
	      coding-system-for-write 'utf-8
	      default-buffer-file-coding-system 'utf-8
	      ring-bell-function 'ignore
	      read-buffer-completion-ignore-case t
	      read-file-name-completion-ignore-case t
	      setq-default completion-ignore-case t)

;; tab bar
;; https://lambdaland.org/posts/2022-07-20_adding_a_clock_to_emacs/
(setq-default display-time-24hr-format t
	      display-time-interval 1
	      tab-bar-close-button-show nil
	      tab-bar-format '(tab-bar-format-history
			       tab-bar-format-tabs
			       tab-bar-separator
			       tab-bar-format-align-right
			       tab-bar-format-global)
	      tab-bar-new-tab-choice "*dashboard*")

(tab-bar-mode 1)

(with-eval-after-load 'time
  (setq-default display-time-mail-function nil
		display-time-mail-string ""))

;; removes client-side decorations in GNOME+Linux
(when (and (eq system-type 'gnu/linux)
           (string-match "GNOME" (or (getenv "XDG_CURRENT_DESKTOP") "")))
  (setq default-frame-alist (append '((undecorated . t)) default-frame-alist)))

;; ensures emacs is maximized on boot
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(provide 'early-init)

;;; early-init.el ends here
