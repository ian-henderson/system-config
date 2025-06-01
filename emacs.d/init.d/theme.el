;;; Package --- theme.el
;;; Commentary:
;;; Code:

;; https://protesilaos.com/emacs/ef-themes-pictures
(use-package ef-themes)

;; https://protesilaos.com/emacs/modus-themes-pictures
(use-package modus-themes)

;; https://protesilaos.com/emacs/standard-themes-pictures
(use-package standard-themes)

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes '((:sunrise . modus-operandi-tinted)
					  ("12:00"  . modus-operandi)
					  ("15:30"  . modus-operandi-tinted)
					  ("17:00"  . modus-vivendi-tinted)
  					  (:sunset  . modus-vivendi)))
  :hook (emacs-startup . circadian-setup))

(provide 'theme)

;;; theme.el ends here
