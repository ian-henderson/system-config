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
  (dashboard-items '((projects . 5)
		     (recents  . 5)))
  (dashboard-item-shortcuts '((projects . "p")
			      (recents  . "r")))
  (dashboard-navigation-cycle t)
  (dashboard-projects-backend 'projectile)
  (dashboard-startup-banner 2)
  ;; (expand-file-name "images/stallman-boat.jpg" user-emacs-directory))
  (dashboard-vertically-center-content t)
  (initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  :init (dashboard-setup-startup-hook))

;; https://github.com/emacs-evil/evil
(use-package evil
  :custom (evil-want-keybinding nil)
  :config
  (defun toggle-evil-mode ()
    "Toggle evil mode."
    (interactive)
    (evil-mode (if (bound-and-true-p evil-mode) 0 1)))
  (global-set-key (kbd "C-c e") 'toggle-evil-mode)
  (evil-mode 1)
  ;; TODO: find a cleaner way to handle this
  (eval-after-load 'vterm
    (dolist (keybinding (mapcar (lambda (i) (format "C-%s" i))
				'("a" "d" "e" "k" "n" "p" "r")))
      (define-key evil-insert-state-map (kbd keybinding) 'vterm--self-insert))))

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
  :custom (shell-file-name (or (executable-find "fish") (executable-find "bash")))
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

;; https://github.com/roman/golden-ratio.el
(use-package golden-ratio
  :config
  (setq golden-ratio-extra-commands
	(append golden-ratio-extra-commands
		'(evil-window-left
		  evil-window-right
		  evil-window-up
		  evil-window-down
		  windmove-left
		  windmove-right
		  windmove-up
		  windmove-down))))

;; https://github.com/magit/magit
;; https://magit.vc/manual
(use-package magit)

;; https://github.com/bbatsov/projectile
;; https://docs.projectile.mx/projectile/index.html
;; A project should have either a git directory or .projectile file.
;; If a project isn't detected, run `(projectile-invalidate-cache)`.
(use-package projectile
  :init (projectile-mode 1)
  :config
  (define-key projectile-mode-map (kbd "C-c p") #'projectile-command-map)
  (dolist (path '("c"
		  "guile"
		  "rust/codecrafters-shell-rust"
  		  "rust/data_structures_and_algorithms"
		  "system-config"))
    (projectile-add-known-project (expand-file-name path "~/Developer"))))

;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters :hook (prog-mode . rainbow-delimiters-mode))

;; https://github.com/akermu/emacs-libvterm
(use-package vterm
  :after evil-mode
  :custom
  (vterm-shell (or (executable-find "fish") (executable-find "bash")))
  :config
  (defun unset-vterm-keys ()
    "Unset vterm keys that overwrite existing keybindings."
    (let ((meta-keys (mapcar (lambda (i) (format "M-%s" i))
			     (append (number-sequence 0 9)
				     '("t" "T" "w" "v" "n" "N" "p" "P" "<up>"
				       "<down>" "<left>" "<right>")))))
      (dolist (key meta-keys)
	(define-key vterm-mode-map (kbd key) nil))))
  :hook
  (vterm-mode . unset-vterm-keys))

(provide 'packages)

;;; packages.el ends here
