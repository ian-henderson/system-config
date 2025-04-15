;;; Package --- theme.el
;;; Commentary:
;;; Code:

(defvar-local dark-themes '(modus-vivendi standard-dark))
(defvar-local dark-themes-tinted '(ef-dream standard-dark))
(defvar-local light-themes '(modus-operandi standard-light))
(defvar-local light-themes-tinted
    '(ef-elea-light ef-reverie standard-light-tinted))

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes `((:sunrise . ,light-themes-tinted)
		      ("12:00"  . ,light-themes)
		      ("15:00"  . ,light-themes-tinted)
		      ("17:00"  . ,dark-themes-tinted)
		      (:sunset  . ,dark-themes)))
  :hook (emacs-startup . circadian-setup))

;; https://protesilaos.com/emacs/ef-themes
;; https://protesilaos.com/emacs/ef-themes-pictures
(use-package ef-themes)

;; https://protesilaos.com/emacs/modus-themes
(use-package modus-themes
  :custom
  (modus-themes-bold-constructs nil)  ; disable bold text
  (modus-themes-italic-constructs t)) ; enable italics

;; https://github.com/kuanyui/moe-theme.el
(use-package moe-theme)

;; https://protesilaos.com/emacs/standard-themes
(use-package standard-themes)

(provide 'theme)

;;; theme.el ends here
