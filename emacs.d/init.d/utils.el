;;; Package --- utils.el
;;; Commentary:
;;; Code:

;; flyspell
(require 'flyspell)
(dolist (hook '(markdown-mode-hook org-mode-hook text-mode-hook))
  (add-hook hook 'flyspell-mode))

(defun load-init-file ()
  "Reload init.el."
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))

(defun load-custom-file ()
  "Generate custom.el if one doesn't exist and load it."
  (setq custom-file (expand-file-name "init.d/custom.el" user-emacs-directory))
  (unless (file-exists-p custom-file)
    (with-temp-buffer
      (insert ";;; Package --- custom.el\n")
      (insert ";;; Commentary:\n")
      (insert ";;; Code:\n\n")
      (insert "(provide 'custom)\n\n")
      (insert ";;; custom.el ends here\n")
      (write-region (point-min) (point-max) custom-file)))
  (load custom-file))

(load-custom-file)

;; https://orgmode.org/
(use-package org
  :ensure nil ; (built-in)
  :custom
  (org-hide-leading-stars t)
  (org-startup-indented t)
  :hook
  (org-mode . org-indent-mode)
  (org-mode . variable-pitch-mode)
  :bind (:map org-mode-map
	      ("C-c l" . org-toggle-link-display)))

;; https://github.com/sabof/org-bullets
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(savehist-mode t)

(provide 'utils)

;;; utils.el ends here
