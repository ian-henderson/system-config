;;; Package --- fonts.el
;;; Commentary:
;;; Code:

(defvar default-font-height 200)
;; (setq-default line-spacing 0.2)

(set-face-attribute
 'default nil :family "Victor Mono" :height default-font-height)

(set-face-attribute
 'fixed-pitch nil :family "Victor Mono" :height default-font-height)

(set-face-attribute
 'variable-pitch nil :family "Adwaita Sans" :height default-font-height)

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
   'default nil :height default-font-height)
  (set-face-attribute
   'fixed-pitch nil :height default-font-height)
  (set-face-attribute
   'variable-pitch nil :height default-font-height))

(global-set-key (kbd "C-=") 'increase-font-size)
(global-set-key (kbd "C--") 'decrease-font-size)
(global-set-key (kbd "C-0") 'reset-font-size)

(provide 'fonts)
;;; fonts.el ends here
