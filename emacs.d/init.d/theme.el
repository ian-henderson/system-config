;;; Package --- theme.el
;;; Commentary:
;;; Code:

;; https://github.com/protesilaos/ef-themes
;; https://protesilaos.com/emacs/ef-themes
;; https://protesilaos.com/emacs/ef-themes-pictures
(use-package ef-themes)

;; https://github.com/protesilaos/modus-themes
;; https://protesilaos.com/emacs/modus-themes
;; https://protesilaos.com/emacs/modus-themes-pictures
(use-package modus-themes)

;; https://github.com/protesilaos/standard-themes
;; https://protesilaos.com/emacs/standard-themes
;; https://protesilaos.com/emacs/standard-themes-pictures
(use-package standard-themes)

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes '(("05:00"  . ef-dream)
		      (:sunrise . ef-reverie)
		      ("12:00"  . ef-spring)
		      ("16:00"  . ef-day)
		      ("19:00"  . modus-vivendi-tinted)
  		      (:sunset  . ef-night)))
  :hook (emacs-startup . circadian-setup))

(provide 'theme)

;;; theme.el ends here
