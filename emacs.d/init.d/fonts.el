;;; Package --- fonts.el
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "init.el" alist)

(defun font-size-reset ()
  "Set font sizes to default sizes."
  (interactive)
  (dolist (face '(default fixed-pitch))	; monospace fonts
    (set-face-attribute face nil
			:family "Ubuntu Sans Mono" :height 130 :weight 'regular))
  (set-face-attribute 'variable-pitch nil ; variable-pitch fonts
		      :family "Ubuntu Sans" :height 130 :weight 'regular))

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
