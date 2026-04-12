;;; Package --- packages.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "init.el" alist)

;; https://github.com/rranelli/auto-package-update.el
;; (use-package auto-package-update
;;   :custom
;;   (auto-package-update-delete-old-versions t)
;;   (auto-package-update-hide-results t)
;;   :init
;;   (auto-package-update-maybe))

;; https://github.com/abo-abo/avy
(use-package avy
  :bind
  ("C-c j" . 'avy-goto-char-2))

;; https://company-mode.github.io
;; complete anything (auto complete)
(use-package company
  :config
  (global-company-mode 1)
  :diminish
  company-mode)

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
  ;; (dashboard-startup-banner 3)
  (dashboard-startup-banner
   (expand-file-name "assets/banners/emacs-bloody.txt"
                     user-emacs-directory))
  ;; (dashboard-startup-banner
  ;;  (directory-files
  ;;   (expand-file-name "assets/banners" user-emacs-directory)
  ;;   t))
  (dashboard-vertically-center-content t)
  (initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  :init
  (dashboard-setup-startup-hook))

;; https://github.com/myrjola/diminish.el
;; https://github.com/jwiegley/use-package#diminishing-and-delighting-minor-modes
(use-package diminish
  :config
  (mapc (lambda (mode)
          (let ((sym (intern (format "%s-mode" mode))))
            (when (fboundp sym)
              (diminish sym))))
        '(abbrev
          auto-revert
          eldoc
          hs-minor
          outline-minor
          which-key
          visual-line)))

;; https://github.com/skeeto/elfeed
(use-package elfeed
  :custom
  (elfeed-feeds '("https://planet.guix.gnu.org/atom.xml"
                  "https://protesilaos.com/books.xml"
                  "https://protesilaos.com/codelog.xml"
                  "https://protesilaos.com/commentary.xml"
                  "https://protesilaos.com/news.xml"
                  "https://protesilaos.com/prot-asks.xml"
                  "https://protesilaos.com/politics.xml"
                  "https://systemcrafters.net/rss/news.xml"
                  "https://thelinuxcast.org/index.xml"
                  "https://news.ycombinator.com/rss"))
  (elfeed-search-filter "@6-months-ago"))

;; https://www.gnu.org/software/emms
(use-package emms
  :bind
  ("C-c P" . emms-pause)
  :config
  (emms-minimalistic)
  (emms-mode-line-disable)
  :custom
  (emms-player-list '(emms-player-vlc)))

;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("LIBERA_USERNAME" "LIBERA_PASSWORD" "LIBERA_FULL_NAME" "MANPATH"))
  :custom
  (shell-file-name (executable-find "bash")))

;; https://codeberg.org/guix/emacs-guix
(use-package guix
  :bind
  ("C-c g" . guix))

;; https://github.com/emacsorphanage/git-gutter-fringe
(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode 1)
  :custom
  (git-gutter-fr:side 'right-fringe)
  :diminish
  git-gutter-mode)

;; https://github.com/magit/magit
;; https://magit.vc/manual
(use-package magit)

;; https://orgmode.org/
(use-package org
  :custom
  (org-adapt-indentation nil)
  (org-hide-leading-stars t)
  (org-startup-indented t)
  :diminish
  org-indent-mode
  :ensure
  nil ; built-in
  :hook
  (org-mode . org-indent-mode))

;; https://github.com/sabof/org-bullets
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; https://github.com/bbatsov/projectile
;; https://docs.projectile.mx/projectile/index.html
;; A project should have either a git directory or .projectile file.
;; If a project isn't detected, run `(projectile-invalidate-cache)`.
(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") #'projectile-command-map)
  (dolist (path '("guix" "nonguix" "system-config"))
    (projectile-add-known-project (expand-file-name path "~/Developer")))
  (projectile-cleanup-known-projects)
  :diminish
  projectile-mode
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
  (defvar visual-fill-column-whitelist
    (mapcar (lambda (name) (intern (format "%s-mode" name)))
            '(elfeed-show
              ert-results
              eww
              fundamental
              help
              Info
              lisp-interaction
              magit-status
              Man
              org
              special)))
  (add-hook 'after-change-major-mode-hook
            (lambda ()
              (when (memq major-mode visual-fill-column-whitelist)
                (visual-fill-column-mode 1))))
  :custom
  (visual-fill-column-center-text t))

(defun rename-vterm-buffer ()
  "Rename vterm buffer to *vterm<i>*, i being the next available number."
  (when (eq major-mode 'vterm-mode)
    (let ((base "*vterm<%d>*")
          (n 0))
      (while (get-buffer (format base n)) (setq n (1+ n)))
      (rename-buffer (format base n) t))))

;; https://github.com/akermu/emacs-libvterm
(use-package vterm
  :bind
  ("C-c t" . vterm)
  :config
  (dolist (key '("w" "t" "T" "f" "b"))
    (define-key vterm-mode-map (kbd (format "M-%s" key)) nil))
  (define-key vterm-mode-map (kbd "C-c v") 'vterm-yank)
  ;; (define-key vterm-mode-map (kbd "M-<backspace>") 'vterm-send-C-w)
  :custom
  (vterm-shell (executable-find "bash"))
  :hook
  (vterm-mode . rename-vterm-buffer))

(provide 'packages)

;;; packages.el ends here
