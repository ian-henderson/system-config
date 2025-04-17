;;; Package --- theme.el
;;; Commentary:
;;; Code:

;; https://protesilaos.com/emacs/modus-themes
(use-package modus-themes
  :custom
  (modus-themes-bold-constructs nil)  ; disable bold text
  (modus-themes-italic-constructs t)) ; enable italics

;; https://protesilaos.com/emacs/standard-themes
(use-package standard-themes)

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes '((:sunrise . standard-light-tinted)
		      ("12:00"  . standard-light)
		      ("17:00"  . standard-light-tinted)
		      ("19:00"  . standard-dark-tinted)
		      (:sunset  . standard-dark)))
  :hook (emacs-startup . circadian-setup))

(provide 'theme)

;;; theme.el ends here
