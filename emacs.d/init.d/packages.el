;;; Package --- packages.el
;;; Commentary:
;;; Code:

;; https://company-mode.github.io
(use-package company ; complete anything (auto complete)
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; https://github.com/emacs-dashboard/emacs-dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-center-content t)
  (dashboard-items '((recents . 5)))
  (dashboard-navigation-cycle t)
  (dashboard-startup-banner
   (expand-file-name "images/stallman-boat.jpg" user-emacs-directory))
  (dashboard-vertically-center-content t)
  :init
  (setq-default initial-buffer-choice
		(lambda () (get-buffer "*dashboard*"))))

;; https://joaotavora.github.io/eglot/
(use-package eglot
  :hook
  (rust-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(rust-mode . ("rust-analyzer"))))

;; https://github.com/emacs-evil/evil
(use-package evil
  :init
  (setq-default evil-want-keybinding nil)
  (defun toggle-evil-mode ()
    "Toggle evil mode."
    (interactive)
    (evil-mode (if (bound-and-true-p evil-mode) -1 1)))
  (global-set-key (kbd "C-c e") 'toggle-evil-mode)
  :config
  (evil-mode 1))

;; https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :after
  evil
  :config
  (evil-collection-init))

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
  (global-git-gutter-mode 1))

;; https://github.com/magit/magit
;; https://magit.vc/manual
(use-package magit)

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
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode 1))

;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (setq rust-format-on-save t)
  (add-hook 'rust-mode-hook (lambda () (flycheck-mode -1))))

;; https://github.com/minad/vertico
(use-package vertico
  :custom
  (completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (vertico-cycle t)
  :config
  (vertico-mode 1))

;; https://github.com/akermu/emacs-libvterm
;; Depends on libvterm-dev and cmake in Debian
(use-package vterm
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
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(provide 'packages)

;;; packages.el ends here
