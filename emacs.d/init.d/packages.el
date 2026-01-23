;;; Package --- packages.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
  :custom
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  :init
  (auto-package-update-maybe))

;; https://github.com/abo-abo/avy
(use-package avy
  :bind
  ("C-c j" . 'avy-goto-char-2))

;; https://company-mode.github.io
;; complete anything (auto complete)
(use-package company
  :hook
  (after-init . global-company-mode))

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
  :init
  (dashboard-setup-startup-hook))

;; https://evil.readthedocs.io/en/latest/index.html
;; https://github.com/emacs-evil/evil
(use-package evil
  :bind
  ("C-c SPC" . evil-mode)
  :config
  (evil-mode 1)
  :custom
  (evil-want-keybinding nil))

;; https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :after
  evil
  :config
  (evil-collection-init))

;; https://github.com/emacs-evil/evil-surround
(use-package evil-surround
  :after
  evil
  :config
  (global-evil-surround-mode 1))

;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("LIBERA_USERNAME" "LIBERA_PASSWORD" "LIBERA_FULL_NAME"))
  :custom
  (shell-file-name (executable-find "bash")))

;; https://github.com/emacsorphanage/git-gutter-fringe
(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode 1)
  :custom
  (git-gutter-fr:side 'right-fringe))

;; https://github.com/roman/golden-ratio.el
(use-package golden-ratio
  :config
  ;; (golden-ratio-mode 1)
  :custom
  (golden-ratio-auto-scale t))

;; https://github.com/magit/magit
;; https://magit.vc/manual
(use-package magit)

;; https://codeberg.org/martianh/mastodon.el
(use-package mastodon
  :custom
  (mastodon-active-user (getenv "MASTODON_USERNAME"))
  (mastodon-instance-url (getenv "MASTODON_INSTANCE_URL")))

;; https://depp.brause.cc/nov.el/
(use-package nov
  :custom
  (nov-text-width 70)
  :hook
  (nov-mode . visual-fill-column-mode)
  :mode
  ("\\.epub\\'" . nov-mode))

;; https://orgmode.org/
(use-package org
  :custom
  (org-adapt-indentation nil)
  (org-hide-leading-stars t)
  (org-startup-indented t)
  :ensure
  nil ; built-in
  :hook
  (org-mode . org-indent-mode))

;; https://github.com/sabof/org-bullets
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; https://github.com/vedang/pdf-tools?tab=readme-ov-file
(use-package pdf-tools
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (setq pdf-view-resize-factor 1.1)
  :magic
  ("%PDF" . pdf-view-mode))

;; https://github.com/bbatsov/projectile
;; https://docs.projectile.mx/projectile/index.html
;; A project should have either a git directory or .projectile file.
;; If a project isn't detected, run `(projectile-invalidate-cache)`.
(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") #'projectile-command-map)
  (dolist (path '("c" "python" "system-config"))
    (projectile-add-known-project (expand-file-name path "~/Developer")))
  (projectile-cleanup-known-projects)
  :init
  (projectile-mode 1))

;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; https://github.com/nflath/sudo-edit
(use-package sudo-edit)

;; https://codeberg.org/joostkremers/visual-fill-column
(use-package visual-fill-column
  :config
  (global-visual-fill-column-mode 1)
  (defun my/manage-visual-fill-column ()
    ;; Centralized logic to enable/disable visual-fill-column-mode.
    (defun modes (names)
      (mapcar (lambda (n)
		(intern (format "%s-mode" n)))
	      names))
    (let ((whitelist (modes '(ert-results
			      fundamental
			      help
			      Info
			      lisp-interaction
			      magit-status
			      Man
			      mastodon
			      minibuffer)))
	  (blacklist (modes '(pdf-view))))
      (cond
       ((memq major-mode whitelist)
	(visual-fill-column-mode 1))
       ((memq major-mode blacklist)
	(visual-fill-column-mode 0)))))
  (add-hook 'after-change-major-mode-hook 'my/manage-visual-fill-column)
  :custom
  (visual-fill-column-center-text t)
  :hook
  (visual-fill-column-mode
   . (lambda () (setq-local visual-fill-column-width (+ fill-column 6)))))

(defun rename-vterm-buffer ()
  "Rename vterm buffer to *vterm<i>*, i being the next available number."
  (when (eq major-mode 'vterm-mode)
    (let ((base "*vterm<%d>*")
	  (n 0))
      (while (get-buffer (format base n)) (setq n (1+ n)))
      (rename-buffer (format base n) t))))

;; https://github.com/akermu/emacs-libvterm
(use-package vterm
  :after
  evil
  :bind
  ("C-c t" . vterm)
  :config
  (dolist (key '("w" "t" "T" "f" "b"))
    (define-key vterm-mode-map (kbd (format "M-%s" key)) nil))
  (define-key vterm-mode-map (kbd "C-c v") 'vterm-yank)
  (define-key vterm-mode-map (kbd "M-<backspace>") 'vterm-send-C-w)
  :custom
  (vterm-shell (executable-find "bash"))
  :hook
  (vterm-mode . evil-emacs-state)
  (vterm-mode . rename-vterm-buffer))

(provide 'packages)

;;; packages.el ends here
