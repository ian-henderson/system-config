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
  (circadian-themes '(
		      ;; (:sunrise . modus-operandi-tinted)
  		      ;; ("11:00"  . modus-operandi)
  		      ;; ("15:30"  . modus-operandi-tinted)
  		      ;; ("17:30"  . modus-vivendi-tinted)
  		      ;; (:sunset  . modus-vivendi)
		      (:sunrise . standard-light-tinted)
  		      ("11:00"  . standard-light)
  		      ("15:30"  . standard-light-tinted)
  		      ("17:30"  . standard-dark-tinted)
  		      (:sunset  . standard-dark)
		      ))
  :hook (emacs-startup . circadian-setup))

(provide 'theme)

;;; theme.el ends here
