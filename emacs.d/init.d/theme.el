;;; Package --- theme.el
;;; Commentary:
;;; Code:

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

;; https://github.com/GuidoSchmidt/circadian.el
(use-package circadian
  :custom
  (calendar-latitude 38.833881)
  (calendar-longitude -104.821365)
  (circadian-themes '((:sunrise . moe-light) (:sunset . moe-dark)))
  :hook (emacs-startup . circadian-setup))

(provide 'theme)

;;; theme.el ends here
