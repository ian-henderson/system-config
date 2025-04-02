;;; Package --- packages.el
;;; Commentary:
;;; Code:

;; https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
  :config
  (setq-default auto-package-update-delete-old-versions t
                auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; https://company-mode.github.io/
(use-package company ; complete anything (auto complete)
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; https://github.com/emacs-dashboard/emacs-dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

;; https://joaotavora.github.io/eglot/
(use-package eglot
  :config
  (add-to-list 'eglot-server-programs
	       '(rust-mode . ("rust-analyzer")))
  (add-hook 'rust-mode-hook 'eglot-ensure))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("LIBERA_USERNAME" "LIBERA_PASSWORD")))

;; https://github.com/emacs-evil/evil
(use-package evil
  :init
  (setq-default evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (defun toggle-evil-mode ()
    "Toggle evil mode."
    (interactive)
    (evil-mode (if (bound-and-true-p evil-mode) -1 1)))
  (global-set-key (kbd "C-c e") #'toggle-evil-mode))

;; https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :after
  evil
  :config
  (evil-collection-init))

;; https://www.flycheck.org/en/latest/user/installation.html
(use-package flycheck
  :config
  (global-flycheck-mode 1))

;; https://github.com/emacsorphanage/git-gutter
(use-package git-gutter
  :config
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

;; https://github.com/sabof/org-bullets
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook (lambda () (rainbow-delimiters-mode 1))))

;; https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (setq-default rust-format-on-save t))

;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(provide 'packages)

;;; packages.el ends here
