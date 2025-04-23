;;; Package --- theme.el
;;; Commentary:
;;; Code:

;; https://protesilaos.com/emacs/modus-themes
(use-package modus-themes
  :custom
  (modus-themes-bold-constructs nil)
  (modus-themes-italic-constructs t))

;; https://protesilaos.com/emacs/standard-themes
(use-package standard-themes)

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  ;; (circadian-themes '((:sunrise . modus-operandi-tinted)
  ;; 		      ("12:00"  . modus-operandi)
  ;; 		      ("15:30"  . modus-operandi-tinted)
  ;; 		      (:sunset  . modus-vivendi-tinted)
  ;; 		      ("20:00"  . modus-vivendi)))
  (circadian-themes '((:sunrise . standard-light-tinted)
  		      ("10:00"  . standard-light)
  		      ("15:30"  . standard-light-tinted)
  		      (:sunset  . standard-dark-tinted)
  		      ("20:00"  . standard-dark)))
  :hook (emacs-startup . circadian-setup))

(provide 'theme)

;;; theme.el ends here
