;;; Package --- packages.el
;;; Commentary:
;;; Code:

;; https://company-mode.github.io/
(use-package company ; complete anything (auto complete)
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; https://github.com/emacs-dashboard/emacs-dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-center-content t)
  (dashboard-items '((recents   . 10)))
  (dashboard-navigation-cycle t)
  (dashboard-startup-banner
   (expand-file-name "images/stallman.gif" user-emacs-directory))
  (dashboard-vertically-center-content t)
  :init
  (setq-default initial-buffer-choice
		(lambda ()
		  (get-buffer "*dashboard*"))))

;; https://joaotavora.github.io/eglot/
(use-package eglot
  :hook (rust-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(rust-mode . ("rust-analyzer"))))

;; https://github.com/emacs-evil/evil
(use-package evil
  ;; :defer t
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

;; https://www.flycheck.org/en/latest/user/installation.html
(use-package flycheck
  :defer t
  :config
  (global-flycheck-mode 1))

;; https://github.com/emacsorphanage/git-gutter
(use-package git-gutter
  :defer t
  :config
  (global-git-gutter-mode 1))

;; https://github.com/magit/magit
;; https://magit.vc/manual
(use-package magit
  :defer t)

;; https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :defer t
  :config
  (setq-default markdown-command "multimarkdown")
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode)))

;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :defer t
  :mode "\\.rs\\'"
  :config (setq-default rust-format-on-save t))

;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(provide 'packages)

;;; packages.el ends here
