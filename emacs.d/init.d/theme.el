;;; Package --- theme.el
;;; Commentary:
;;; Code:

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes '((:sunrise . standard-dark-tinted)
		      ("10:00"  . standard-light-tinted)
		      ("12:00"  . standard-light)
		      ("17:00"  . standard-light-tinted)
		      (:sunset  . standard-dark-tinted)
		      ("20:00"  . standard-dark)))
  :init
  (circadian-setup))

;; https://protesilaos.com/emacs/modus-themes
(use-package modus-themes
  :custom
  (modus-themes-bold-constructs nil)  ; Enable bold text
  (modus-themes-italic-constructs t)) ; Enable italics

;; https://github.com/kuanyui/moe-theme.el
(use-package moe-theme)

;; https://protesilaos.com/emacs/standard-themes
(use-package standard-themes)

(provide 'theme)

;;; theme.el ends here
