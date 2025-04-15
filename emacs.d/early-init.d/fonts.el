;;; Package --- fonts.el
;;; Commentary:
;;; Code:

(defvar-local fixed-pitch-font-height 225)

;; DejaVu Sans Mono, Liberation Mono
(dolist (face '(default fixed-pitch))
  (set-face-attribute face nil
		      :family "DejaVu Sans Mono"
		      :height fixed-pitch-font-height))

(defvar-local variable-pitch-font-height 250)

;; DejaVu Serif, FreeSerif, Libre Baskerville, Liberation Serif
(set-face-attribute 'variable-pitch nil
		    :family "DejaVu Serif"
		    :height variable-pitch-font-height)

(defun increase-font-size ()
  "Increase font size."
  (interactive)
  (dolist (face '(default fixed-pitch variable-pitch))
    (set-face-attribute
     face nil
     :height (ceiling (* 1.1 (face-attribute face :height))))))

(defun decrease-font-size ()
  "Decrease font size."
  (interactive)
  (dolist (face '(default fixed-pitch variable-pitch))
    (set-face-attribute
     face nil
     :height (ceiling (* 0.9 (face-attribute face :height))))))

(defun reset-font-size ()
  "Reset font size."
  (interactive)
  (set-face-attribute
   'default nil :height fixed-pitch-font-height)
  (set-face-attribute
   'fixed-pitch nil :height fixed-pitch-font-height)
  (set-face-attribute
   'variable-pitch nil :height variable-pitch-font-height))

(global-set-key-list '(("C-=" . increase-font-size)
		       ("C--" . decrease-font-size)
		       ("C-0" . reset-font-size)))

(provide 'fonts)

;;; fonts.el ends here
