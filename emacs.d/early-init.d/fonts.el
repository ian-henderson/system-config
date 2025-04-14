;;; Package --- fonts.el
;;; Commentary:
;;; Code:

(defvar fixed-pitch-font-height 180)

(dolist (face '(default fixed-pitch))
  (set-face-attribute face nil
		      :family "IBM Plex Mono"
		      :height fixed-pitch-font-height))

(defvar variable-pitch-font-height 320)

(set-face-attribute 'variable-pitch nil
		    :family "IBM Plex Serif"
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
