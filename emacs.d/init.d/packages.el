;;; Package --- packages.el
;;; Commentary:
;;; Code:

;; https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
  :custom
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  :init
  (auto-package-update-maybe))

;; https://github.com/dholm/benchmark-init-el
(use-package benchmark-init
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

;; https://company-mode.github.io
(use-package company ; complete anything (auto complete)
  :init
  (add-hook 'after-init-hook 'global-company-mode))

;; https://github.com/emacs-dashboard/emacs-dashboard
(use-package dashboard
  :custom
  (dashboard-center-content t)
  (dashboard-items '((recents . 5)))
  (dashboard-navigation-cycle t)
  (dashboard-startup-banner 1)
  (dashboard-vertically-center-content t)
  (initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  :init
  (dashboard-setup-startup-hook))

;; https://joaotavora.github.io/eglot
(use-package eglot
  :hook
  (rust-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(rust-mode . ("rust-analyzer"))))

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
  :config (evil-collection-init))

;; https://github.com/emacs-evil/evil-surround
(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :custom
  (shell-file-name (or (executable-find "fish") (executable-find "bash")))
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("LIBERA_USERNAME" "LIBERA_PASSWORD" "LIBERA_FULL_NAME")))

;; https://github.com/wwwjfy/emacs-fish
(use-package fish-mode)

;; https://github.com/lassik/emacs-format-all-the-code
(use-package format-all
  :commands
  format-all-mode
  :custom
  (format-all-formatters '(("Shell" (shfmt "-ci"))))
  :hook
  (prog-mode . format-all-mode)
  (prog-mode . format-all-ensure-formatter))

;; https://www.flycheck.org/en/latest/user/installation.html
(use-package flycheck
  :config
  (global-flycheck-mode 1))

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

;; https://github.com/minad/marginalia
(use-package marginalia
  :init
  (marginalia-mode t))

;; https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :config
  (setq-default markdown-command "multimarkdown")
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode)))

;; https://github.com/bbatsov/projectile
;; https://docs.projectile.mx/projectile/index.html
(use-package projectile
  :custom
  (projectile-project-search-path
   '("~/Developer/guile"
     "~/Developer/rust/codecrafters-shell-rust"
     "~/Developer/rust/data_structures_and_algorithms"
     "~/Developer/system-config"))
  :init
  (projectile-mode t)
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (setq rust-format-on-save t)
  (add-hook 'rust-mode-hook (lambda () (flycheck-mode nil))))

;; https://github.com/minad/vertico
(use-package vertico
  :init
  (vertico-mode t))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode t))

(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; https://github.com/akermu/emacs-libvterm
;; Debian dependencies: libvterm-dev, cmake
(use-package vterm
  :if
  (eq system-type 'gnu/linux)
  :custom
  (vterm-shell (or (executable-find "fish") (executable-find "bash")))
  :config
  (defun unset-vterm-keys ()
    "Unset vterm keys that overwrite existing keybindings."
    (let ((meta-keys (mapcar (lambda (i)
			       (format "M-%s" i))
			     (append
			      (number-sequence 0 9)
			      '("t" "T" "w" "(" ")" "<up>"
				"<down>" "<left>" "<right>")))))
      (mapc (lambda (key)
	      (define-key vterm-mode-map (kbd key) nil))
	    (append meta-keys '("<f5>")))))

  (with-eval-after-load 'vterm
    (add-hook 'vterm-mode-hook #'unset-vterm-keys)))

;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(provide 'packages)

;;; packages.el ends here
