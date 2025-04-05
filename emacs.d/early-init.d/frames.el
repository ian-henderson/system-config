;;; Package --- frames.el
;;; Commentary:
;;; Code:

(defvar frames-keybindings-list
  (append
   '(("C-c n" . tab-rename)
     ("M-9"   . tab-bar-switch-to-prev-tab)
     ("M-0"   . tab-bar-switch-to-next-tab)
     ("M-("   . tab-bar-move-tab-backward)
     ("M-)"   . tab-bar-move-tab)
     ("M-t"   . tab-bar-new-tab)
     ("M-T"   . tab-bar-undo-close-tab)
     ("M-w"   . tab-bar-close-tab))
   ;; Dynamically generated keybindings for M-1 through M-8
   (mapcar (lambda (i)
	     (cons (format "M-%s" i)
		   `(lambda ()
		      (interactive)
		      (tab-bar-select-tab ,i))))
	   (number-sequence 1 8))))

(global-set-key-list frames-keybindings-list)

(display-battery-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Adds clock, usage, and battery to tab bar
(setq-default display-time-24hr-format t
	      display-time-interval 1
	      tab-bar-format '(tab-bar-format-tabs
			       tab-bar-format-align-right
			       tab-bar-format-global))
(display-time-mode 1)
(with-eval-after-load 'time
  (setq-default display-time-mail-function nil
		display-time-mail-string ""))

;; tab bar
(setq tab-bar-close-button-show nil
      tab-bar-new-tab-choice "*dashboard*")
(tab-bar-mode 1)

;; removes client-side decorations in GNOME+Linux
(when (and (eq system-type 'gnu/linux)
           (string-match "GNOME" (or (getenv "XDG_CURRENT_DESKTOP") "")))
  (setq default-frame-alist (append '((undecorated . t)) default-frame-alist)))

;; ensures emacs is maximized on boot
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(provide 'frames)

;;; frames.el ends here
