;;; Package --- packages.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
  :custom
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  :init (auto-package-update-maybe))

;; https://github.com/abo-abo/avy
(use-package avy :config (global-set-key (kbd "C-c j") 'avy-goto-char-2))

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
  ;; (expand-file-name "images/stallman-boat.jpg" user-emacs-directory))
  (dashboard-vertically-center-content t)
  (initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  :init (dashboard-setup-startup-hook))

;; https://evil.readthedocs.io/en/latest/index.html
;; https://github.com/emacs-evil/evil
(use-package evil
  :custom (evil-want-keybinding nil)
  :config
  (defun toggle-evil-mode ()
    "Toggle evil mode."
    (interactive)
    (evil-mode (if (bound-and-true-p evil-mode) 0 1)))
  (global-set-key (kbd "C-c SPC") 'toggle-evil-mode)
  (evil-mode 1))

;; https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :after evil
  :config (evil-collection-init))

;; https://github.com/emacs-evil/evil-surround
(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("LIBERA_USERNAME" "LIBERA_PASSWORD" "LIBERA_FULL_NAME"))
  :custom (shell-file-name (or (executable-find "fish")
			       (executable-find "bash"))))

;; https://github.com/emacsorphanage/git-gutter-fringe
(use-package git-gutter-fringe
  :config (global-git-gutter-mode 1)
  :custom (git-gutter-fr:side 'right-fringe))

;; https://github.com/roman/golden-ratio.el
(use-package golden-ratio
  :config (golden-ratio-mode 1)
  :custom (golden-ratio-auto-scale t))

;; https://github.com/magit/magit
;; https://magit.vc/manual
(use-package magit)

;; https://depp.brause.cc/nov.el/
(use-package nov
  :mode ("\\.epub\\'" . nov-mode)
  :hook (nov-mode . visual-fill-column-mode)
  :custom (nov-text-width 70))

;; https://orgmode.org/
(use-package org
  :ensure nil ; built-in
  :custom
  (org-adapt-indentation nil)
  (org-hide-leading-stars t)
  (org-startup-indented t)
  :hook (org-mode . org-indent-mode))

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
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; https://github.com/nflath/sudo-edit
(use-package sudo-edit)

(defun my-visual-fill-column-setup ()
  "Initialize local state for visual-fill-column buffers."
  (setq-local visual-fill-column-center-text t
	      visual-fill-column-width (+ fill-column 6)))

;; https://codeberg.org/joostkremers/visual-fill-column
(use-package visual-fill-column
  :config
  (global-visual-fill-column-mode 1)
  (dolist (mode '(help))
    (add-hook (intern (format "%s-mode-hook" mode))
	      'visual-fill-column-mode))
  :hook (visual-fill-column-mode . my-visual-fill-column-setup))

(defun rename-vterm-buffer ()
  "Rename vterm buffer to *vterm<i>*, where i is the next available number."
  (when (eq major-mode 'vterm-mode)
    (let ((n 0)
	  (base "*vterm<%d>*"))
      (while (get-buffer (format base n))
	(setq n (1+ n)))
      (rename-buffer (format base n) t))))

;; https://github.com/akermu/emacs-libvterm
(use-package vterm
  :after evil
  :config
  (dolist (key '("w" "t" "T" "f" "b" "<left>" "<right>"))
    (define-key vterm-mode-map (kbd (format "M-%s" key)) nil))
  (define-key vterm-mode-map (kbd "C-c v") 'vterm-yank)
  (define-key vterm-mode-map (kbd "M-<backspace>") 'vterm-send-C-w)
  :custom (vterm-shell (or (executable-find "fish") (executable-find "bash")))
  :hook
  (vterm-mode . evil-emacs-state)
  (vterm-mode . rename-vterm-buffer))

(provide 'packages)

;;; packages.el ends here
