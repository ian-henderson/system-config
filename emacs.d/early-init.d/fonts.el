;;; Package --- fonts.el
;;; Commentary:
;;; Code:

(defvar fonts-list '("EB Garamond"
		     "Fixedsys Excelsior"
		     "Iosevka"
		     "Iosevka Etoile"
		     "SF Mono"))

(defvar monospace-font (nth 2 fonts-list))
(defvar monospace-font-height 200)

(dolist (face '(default fixed-pitch))
  (set-face-attribute face nil
		      :family monospace-font
		      :height monospace-font-height))

(defvar serif-font (nth 3 fonts-list))
(defvar serif-font-height 200)

(set-face-attribute
 'variable-pitch nil :family serif-font :height serif-font-height)

(defun increase-font-size ()
  "Increase font size."
  (interactive)
  (set-face-attribute
   'default nil
   :height (ceiling (* 1.1 (face-attribute 'default :height))))
  (set-face-attribute
   'fixed-pitch nil
   :height (ceiling (* 1.1 (face-attribute 'default :height))))
  (set-face-attribute
   'variable-pitch nil
   :height (ceiling (* 1.1 (face-attribute 'variable-pitch :height)))))

(defun decrease-font-size ()
  "Decrease font size."
  (interactive)
  (set-face-attribute
   'default nil
   :height (ceiling (* 0.9 (face-attribute 'default :height))))
  (set-face-attribute
   'fixed-pitch nil
   :height (ceiling (* 0.9 (face-attribute 'default :height))))
  (set-face-attribute
   'variable-pitch nil
   :height (ceiling (* 0.9 (face-attribute 'variable-pitch :height)))))

(defun reset-font-size ()
  "Reset font size."
  (interactive)
  (set-face-attribute
   'default nil :height monospace-font-height)
  (set-face-attribute
   'fixed-pitch nil :height monospace-font-height)
  (set-face-attribute
   'variable-pitch nil :height serif-font-height))

(defvar key-bindings-list
  '(("C-=" . increase-font-size)
    ("C--" . decrease-font-size)
    ("C-0" . reset-font-size)))

(global-set-key-list key-bindings-list)

(provide 'fonts)

;;; fonts.el ends here
