;;; Package --- packages.el
;;; Commentary:
;;; Code:

;; https://github.com/Malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :config
  ;; (dolist (hook '(emacs-lisp-mode lisp-mode scheme-mode))
  ;;   (add-hook hook #'aggressive-indent-mode))
  ;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  (global-aggressive-indent-mode 1))

;; https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
  :custom
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  :init (auto-package-update-maybe))

;; https://github.com/dholm/benchmark-init-el
(use-package benchmark-init :hook (after-init . benchmark-init/deactivate))

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
  (dashboard-startup-banner
   (expand-file-name "images/stallman-boat.jpg" user-emacs-directory))
  (dashboard-vertically-center-content t)
  (initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  :init (dashboard-setup-startup-hook))

;; https://joaotavora.github.io/eglot
(use-package eglot
  :hook (rust-mode . eglot-ensure)
  :config (add-to-list 'eglot-server-programs
		       '(rust-mode . ("rust-analyzer"))))

;; https://github.com/emacs-evil/evil
(use-package evil
  :custom (evil-want-keybinding nil)
  :config
  (defun toggle-evil-mode ()
    "Toggle evil mode."
    (interactive)
    (evil-mode (if (bound-and-true-p evil-mode) 0 1)))
  (global-set-key (kbd "C-c e") 'toggle-evil-mode))

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

;; https://github.com/wwwjfy/emacs-fish
(use-package fish-mode)

;; https://github.com/lassik/emacs-format-all-the-code
;; https://clang.llvm.org/docs/ClangFormat.html
;; https://github.com/patrickvane/shfmt
(use-package format-all
  :commands format-all-mode
  :config
  (setq-default format-all-formatters
		'(("C" (clang-format "--style" "Mozilla"))
		  ("Shell" (shfmt "-ci"))))
  :hook
  (prog-mode . format-all-mode)
  (prog-mode . format-all-ensure-formatter))

;; https://www.flycheck.org/en/latest/user/installation.html
(use-package flycheck :config (global-flycheck-mode 1))

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
  (dolist (f '(evil-window-left
	       evil-window-right
	       evil-window-up
	       evil-window-down
	       windmove-left
	       windmove-right
	       windmove-up
	       windmove-down))
    (add-to-list 'golden-ratio-extra-commands f)))

;; https://github.com/json-emacs/json-mode
(use-package json-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
  (add-to-list 'auto-mode-alist '("\\.jsonc\\'" . jsonc-mode)))

;; https://github.com/magit/magit
;; https://magit.vc/manual
(use-package magit)

;; https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :custom (markdown-command "multimarkdown")
  :config
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode)))

;; https://github.com/jaypei/emacs-neotree
(use-package neotree
  :custom
  (neo-theme 'ascii)
  (neo-window-width 30)
  :bind ("<f8>" . neotree-toggle))

;; https://www.emacswiki.org/emacs/%20%20ParEdit
;; https://mumble.net/~campbell/emacs/paredit.html
(use-package paredit
  :config
  (dolist (hook '(emacs-lisp-mode-hook lisp-mode-hook scheme-mode-hook))
    (add-hook hook #'enable-paredit-mode)))

;; https://github.com/bbatsov/projectile
;; https://docs.projectile.mx/projectile/index.html
(use-package projectile
  :config
  (projectile-mode t)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (mapc (lambda (path)
	  (projectile-add-known-project (concat "~/Developer/" path)))
	'("guile"
	  "rust/codecrafters-shell-rust"
	  "rust/data_structures_and_algorithms"
	  "system-config"))
  (projectile-cleanup-known-projects))

;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters :hook (prog-mode . rainbow-delimiters-mode))

;; https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :custom (rust-format-on-save t)
  :mode "\\.rs\\'"
  :config (add-hook 'rust-mode-hook (lambda () (flycheck-mode nil))))

;; https://github.com/slime/slime
(use-package slime :custom (inferior-lisp-program "sbcl"))

;; https://github.com/akermu/emacs-libvterm
;; Debian dependencies: libvterm-dev, cmake
(use-package vterm
  :custom (vterm-shell (or (executable-find "fish") (executable-find "bash")))
  :config
  (defun unset-vterm-keys ()
    "Unset vterm keys that overwrite existing keybindings."
    (let ((meta-keys (mapcar (lambda (i) (format "M-%s" i))
			     (append
			      (number-sequence 0 9)
			      '("t" "T" "w" "v" "n" "N" "p" "P" "<up>" "<down>"
				"<left>" "<right>")))))
      (mapc (lambda (key)
	      (define-key vterm-mode-map (kbd key) nil))
	    (append meta-keys '("<f5>")))))
  :hook (vterm-mode . unset-vterm-keys))

;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(provide 'packages)

;;; packages.el ends here
