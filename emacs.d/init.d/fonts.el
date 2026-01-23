;;; Package --- fonts.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "init.el" alist)

(defvar monospace-font-faces '(default fixed-pitch fixed-pitch-serif))
(defvar monospace-font-family "PT Mono")
(defvar monospace-font-height 130)

(defvar variable-font-faces '(variable-pitch))
(defvar variable-font-family "PT Sans")
(defvar variable-font-height 160)

(defun font-size-reset ()
  "Set font sizes to default sizes."
  (interactive)
  (dolist (f monospace-font-faces)
    (set-face-attribute f nil
			:family monospace-font-family
			:height monospace-font-height
			:weight 'regular))
  (dolist (f variable-font-faces)
    (set-face-attribute f nil
			:family variable-font-family
			:height variable-font-height
			:weight 'regular)))

(font-size-reset)

(custom-set-faces
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit fixed-pitch))))
 '(org-verbatim ((t (:inherit fixed-pitch))))
 '(tab-bar-tab ((t (:inherit fixed-pitch))))
 '(tab-bar-tab-active ((t (:inherit fixed-pitch)))))

(defun font-size-set (calc-font-size)
  "Set font size using CALC-FONT-SIZE lambda.
CALC-FONT-SIZE takes the current face height and returns a new height.
The function is applied to the :height attribute of each relevant face (default,
fixed-pitch, variable-pitch)."
  (dolist (f (append monospace-font-faces variable-font-faces))
    (set-face-attribute
     f nil :height (funcall calc-font-size (face-attribute f :height)))))

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
