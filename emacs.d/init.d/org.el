;;; Package --- org.el
;;; Commentary:
;;; Code:

;; https://orgmode.org/
(use-package org
  :ensure nil
  :custom
  (org-hide-leading-stars t)
  (org-startup-indented t)
  :hook
  (org-mode . org-indent-mode)
  (org-mode . variable-pitch-mode))

;; https://github.com/sabof/org-bullets
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

;; https://github.com/bastibe/org-journal
(use-package org-journal
  :defer t
  :custom
  (org-journal-date-format "%A, %d %B %Y")
  (org-journal-dir "~/Documents/Journal/")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-file-type 'daily)
  (org-journal-prefix-key "C-c j"))

(provide 'org)

;;; org.el ends here
