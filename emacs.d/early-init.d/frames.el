;;; Package --- frames.el
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "early-init.el" cons-list)

(defun frame-change-dimension (set-frame-function factor)
  "Change the current frame height or width.
Arguments: SET-FRAME-FUNCTION (`set-frame-height` or `set-frame-width`)
and FACTOR (number)."
  (funcall set-frame-function
	   (selected-frame) (* factor (frame-height))))

(defun frame-height-decrease ()
  "Decrease the current frame height."
  (interactive)
  (frame-change-dimension #'set-frame-height 0.9))

(defun frame-height-increase ()
  "Increase the current frame height."
  (interactive)
  (frame-change-dimension #'set-frame-height 1.1))

(defun frame-width-decrease ()
  "Decrease the current frame width."
  (interactive)
  (frame-change-dimension #'set-frame-width 0.9))

(defun frame-width-increase ()
  "Increase the current frame width."
  (interactive)
  (frame-change-dimension #'set-frame-width 1.1))

(defvar frames-keybindings-list
  (append
   '(("C-c n"       . tab-rename)
     ("M-9"         . tab-bar-switch-to-prev-tab)
     ("M-0"         . tab-bar-switch-to-next-tab)
     ("M-("         . tab-bar-move-tab-backward)
     ("M-)"         . tab-bar-move-tab)
     ("M-t"         . tab-bar-new-tab)
     ("M-T"         . tab-bar-undo-close-tab)
     ("M-w"         . tab-bar-close-tab)
     ("M-S-<left>"  . frame-width-decrease)
     ("M-S-<right>" . frame-width-increase)
     ("M-S-<up>"    . frame-height-increase)
     ("M-S-<down>"  . frame-height-decrease))
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

;; https://lambdaland.org/posts/2022-07-20_adding_a_clock_to_emacs/
(setq-default tab-bar-format '(tab-bar-format-history
			       tab-bar-format-tabs
			       tab-bar-separator
			       tab-bar-format-align-right
			       tab-bar-format-global)
	      display-time-24hr-format t
	      display-time-interval 1)

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
