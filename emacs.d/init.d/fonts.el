;;; Package --- fonts.el
;;; Commentary:
;;; Code:

(defvar monospace-font-height 225)
(defvar serif-font-height 350)

(set-face-attribute
 'default nil
 :family "Maple Mono"
 :height monospace-font-height)

(set-face-attribute
 'fixed-pitch nil
 :family "Maple Mono"
 :height monospace-font-height)

(set-face-attribute
 'variable-pitch nil
 :family "Liberation Serif"
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

(global-set-key (kbd "C-=") 'increase-font-size)
(global-set-key (kbd "C--") 'decrease-font-size)
(global-set-key (kbd "C-0") 'reset-font-size)

(provide 'fonts)

;;; fonts.el ends here
