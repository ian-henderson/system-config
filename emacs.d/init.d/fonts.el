;;; Package --- fonts.el
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "init.el" alist)

(defvar-local font-family-default "Ubuntu Sans Mono")
(defvar-local font-height-default 180)

(defvar-local font-family-variable "Ubuntu Sans")
(defvar-local font-height-variable 250)

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

(defun font-size-set (calc-font-size)
  "Set font size using CALC-FONT-SIZE lambda.
CALC-FONT-SIZE takes the current face height and returns a new height.
The function is applied to the :height attribute of each relevant face (default,
fixed-pitch, variable-pitch)."
  (dolist (face '(default fixed-pitch variable-pitch))
    (set-face-attribute
     face nil :height (funcall calc-font-size (face-attribute face :height)))))

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
