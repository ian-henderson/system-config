;;; Package --- fonts.el
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "early-init.el" cons-list)

;; Anonymous Pro, Courier Prime, Courier Prime Code, FreeMono, Go Mono, Hack,
;; Iosevka, Liberation Mono
(defvar-local font-family-default "FreeMono")
(defvar-local font-height-default 220)

;; DejaVu Serif, EB Garamond, FreeSerif, Go, Libre Baskerville,
;; Liberation Serif
(defvar-local font-family-variable "FreeSerif")
(defvar-local font-height-variable 300)

(defun font-size-reset ()
  "Set font sizes to default sizes."
  (interactive)
  (dolist (face '(default fixed-pitch))
    (set-face-attribute face nil
			:family font-family-default
			:height font-height-default))
  (set-face-attribute 'variable-pitch nil
		      :family font-family-variable
		      :height font-height-variable))

(font-size-reset)

(defun font-size-set (set-font)
  "Set font size with SET-FONT (lambda number)."
  (dolist (face '(default fixed-pitch variable-pitch))
    (set-face-attribute
     face nil :height (funcall set-font (face-attribute face :height)))))

(defun font-size-increase ()
  "Increase font size."
  (interactive)
  (font-size-set (lambda (size) (+ size 10))))

(defun font-size-decrease ()
  "Decrease font size."
  (interactive)
  (font-size-set (lambda (size) (- size 10))))

(global-set-key-list '(("C-=" . font-size-increase)
		       ("C--" . font-size-decrease)
		       ("C-0" . font-size-reset)))

(provide 'fonts)

;;; fonts.el ends here
