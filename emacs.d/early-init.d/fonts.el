;;; Package --- fonts.el
;;; Commentary:
;;; Code:

(defvar monospace-font "Terminus")
(defvar monospace-font-height 250)

(defvar serif-font "Liberation Serif")
(defvar serif-font-height 350)

(set-face-attribute
 'default nil
 :family monospace-font
 :height monospace-font-height)

(set-face-attribute
 'fixed-pitch nil
 :family monospace-font
 :height monospace-font-height)

(set-face-attribute
 'variable-pitch nil
 :family serif-font
 :height serif-font-height)

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
