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

(use-package eww
  :ensure nil
  :custom
  (eww-search-prefix "https://lite.duckduckgo.com/lite?q=")
  (shr-width nil)
  :config
  (dolist (keybinding '("M-n" "M-N"))
    (define-key eww-mode-map (kbd keybinding) nil)))

;; https://orgmode.org/
(use-package org
  :ensure nil
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

(global-set-key-list '(("C-c u" . browse-url-at-point)
		       ("C-c c" . clipboard-kill-ring-save)
		       ("C-c v" . clipboard-yank)
		       ("C-c x" . clipboard-kill-region)))

(desktop-save-mode 1)
(setq-default desktop-lazy-verbose t
              desktop-load-locked-desktop t
              desktop-save t)

;; Deletes trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'utils)

;;; utils.el ends here
