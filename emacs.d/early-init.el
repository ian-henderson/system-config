;;; Package --- early-init.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(prefer-coding-system 'utf-8)

(display-battery-mode 1)
(display-time-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; https://lambdaland.org/posts/2022-07-20_adding_a_clock_to_emacs/
(setq-default
 coding-system-for-read 'utf-8
 coding-system-for-write 'utf-8
 completion-ignore-case t
 default-buffer-file-coding-system 'utf-8
 display-time-24hr-format t
 display-time-interval 1
 read-buffer-completion-ignore-case t
 read-file-name-completion-ignore-case t
 ring-bell-function 'ignore
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
;; (when (and (eq system-type 'gnu/linux)
;;            (string-match "GNOME" (getenv "XDG_CURRENT_DESKTOP") ))
;;   (add-to-list 'default-frame-alist '(undecorated . t)))

;; maximize frame on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(provide 'early-init)

;;; early-init.el ends here
