;;; Package --- packages.el
;;; Commentary:
;;; Code:

;; https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
  :custom
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  :init (auto-package-update-maybe))

;; https://company-mode.github.io
;; complete anything (auto complete)
(use-package company :hook (after-init . global-company-mode))

;; https://github.com/emacs-dashboard/emacs-dashboard
(use-package dashboard
  :custom
  (dashboard-center-content t)
  (dashboard-items '((bookmarks . 5)
		     (projects  . 5)
		     (recents   . 5)))
  (dashboard-item-shortcuts '((bookmarks . "m")
			      (projects  . "p")
			      (recents   . "r")))
  (dashboard-navigation-cycle t)
  (dashboard-projects-backend 'projectile)
  (dashboard-startup-banner 3)
  ;; (expand-file-name "images/emacs.svg" user-emacs-directory))
  (dashboard-vertically-center-content t)
  (initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  :init (dashboard-setup-startup-hook))

;; https://github.com/emacs-evil/evil
(use-package evil
  :custom
  (evil-want-keybinding nil)
  :config
  (defun toggle-evil-mode ()
    "Toggle evil mode."
    (interactive)
    (evil-mode (if (bound-and-true-p evil-mode) 0 1)))
  (global-set-key (kbd "C-c e") 'toggle-evil-mode)
  (evil-mode 1))

;; https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; https://github.com/emacs-evil/evil-surround
(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :custom (shell-file-name (or (executable-find "fish")
			       (executable-find "bash")))
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("LIBERA_USERNAME" "LIBERA_PASSWORD" "LIBERA_FULL_NAME")))

;; https://github.com/emacsorphanage/git-gutter
(use-package git-gutter
  :config
  (custom-set-variables
   '(git-gutter:update-interval 2)
   '(git-gutter:hide-gutter t))
  (global-git-gutter-mode t))

;; https://github.com/magit/magit
;; https://magit.vc/manual
(use-package magit)

;; https://depp.brause.cc/nov.el/
(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode)
  :hook (nov-mode . visual-fill-column-mode)
  :custom
  (nov-text-width 80))

;; https://orgmode.org/
(use-package org
  :ensure nil ; built-in
  :custom
  (org-adapt-indentation nil)
  (org-hide-leading-stars t)
  (org-startup-indented t)
  :hook
  (org-mode . org-indent-mode))

;; https://github.com/sabof/org-bullets
(use-package org-bullets)
  ;; :hook (org-mode . org-bullets-mode)

;; https://github.com/vedang/pdf-tools?tab=readme-ov-file
(use-package pdf-tools
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (setq pdf-view-resize-factor 1.1))

;; https://github.com/bbatsov/projectile
;; https://docs.projectile.mx/projectile/index.html
;; A project should have either a git directory or .projectile file.
;; If a project isn't detected, run `(projectile-invalidate-cache)`.
(use-package projectile
  :init (projectile-mode 1)
  :config
  (define-key projectile-mode-map (kbd "C-c p") #'projectile-command-map)
  (dolist (path '("c" "python" "system-config"))
    (projectile-add-known-project (expand-file-name path "~/Developer")))
  (projectile-cleanup-known-projects))

;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters :hook (prog-mode . rainbow-delimiters-mode))

;; https://codeberg.org/joostkremers/visual-fill-column
(use-package visual-fill-column
  :hook
  (help-mode . visual-fill-column-mode)
  (Info-mode . visual-fill-column-mode)
  (Man-mode . visual-fill-column-mode)
  (org-mode . visual-fill-column-mode)
  (WoMan-mode . visual-fill-column-mode)
  (visual-fill-column-mode . visual-fill-column-toggle-center-text))

;; https://github.com/akermu/emacs-libvterm
(defun rename-vterm-buffer ()
  "Rename vterm buffer to *vterm<i>*, where i is the next available number."
  (when (eq major-mode 'vterm-mode)
    (let ((n 0)
	  (base "*vterm<%d>*"))
      (while (get-buffer (format base n))
	(setq n (1+ n)))
      (rename-buffer (format base n) t))))
(use-package vterm
  :after evil
  :hook
  (vterm-mode . evil-emacs-state)
  (vterm-mode . rename-vterm-buffer)
  :custom (vterm-shell (or (executable-find "fish")
			   (executable-find "bash")))
  :config
  (dolist (key (mapcar (lambda (key) (format "M-%s" key))
		       '("w" "t" "T" "p" "P" "n" "N")))
    (define-key vterm-mode-map (kbd key) nil))
  (define-key vterm-mode-map (kbd "C-c v") 'vterm-yank)
  (define-key vterm-mode-map (kbd "M-<backspace>") 'vterm-send-C-w))

(provide 'packages)

;;; packages.el ends here
