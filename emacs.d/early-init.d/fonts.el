;;; Package --- fonts.el
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "early-init.el" cons-list)

(defvar-local fixed-pitch-font-height 180)

;; Anka/Coder, Anonymous Pro, Courier Prime, Courier Prime Code, FreeMono,
;; Go Mono, Hack, Iosevka, Liberation Mono, ProggyVector
(dolist (face '(default fixed-pitch))
  (set-face-attribute face nil
		      :family "Hack"
		      :height fixed-pitch-font-height))

(defvar-local variable-pitch-font-height 350)

;; DejaVu Serif, EB Garamond, FreeSerif, Go, Libre Baskerville,
;; Liberation Serif
(set-face-attribute 'variable-pitch nil
		    :family "Liberation Serif"
		    :height variable-pitch-font-height)

(defun font-size-change (factor)
  "Multiply font size with FACTOR (number)."
  (dolist (face '(default fixed-pitch variable-pitch))
    (set-face-attribute
     face nil
     :height (ceiling (* factor (face-attribute face :height))))))

(defun font-size-increase ()
  "Increase font size."
  (interactive)
  (font-size-change 1.1))

(defun font-size-decrease ()
  "Decrease font size."
  (interactive)
  (font-size-change 0.9))

(defun font-size-reset ()
  "Reset font size."
  (interactive)
  (set-face-attribute
   'default nil :height fixed-pitch-font-height)
  (set-face-attribute
   'fixed-pitch nil :height fixed-pitch-font-height)
  (set-face-attribute
   'variable-pitch nil :height variable-pitch-font-height))

(global-set-key-list '(("C-=" . font-size-increase)
		       ("C--" . font-size-decrease)
		       ("C-0" . font-size-reset)))

(provide 'fonts)

;;; fonts.el ends here
