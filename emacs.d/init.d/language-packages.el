;;; Package --- language-packages.el
;;; Commentary:
;;; Code:

;; https://github.com/Malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :config
  ;; (dolist (hook '(emacs-lisp-mode lisp-mode scheme-mode))
  ;;   (add-hook hook #'aggressive-indent-mode))
  (add-to-list 'aggressive-indent-excluded-modes 'c-mode)
  (global-aggressive-indent-mode 1))

;; https://joaotavora.github.io/eglot
(use-package eglot
  :hook
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  (rust-mode . eglot-ensure)
  :config
  (setq eglot-server-programs
	(append eglot-server-programs
		'((rust-mode . ("rust-analyzer"))
		  (c-mode . ("clangd"))
		  (c++-mode . ("clangd"))))))

;; https://github.com/wwwjfy/emacs-fish
(use-package fish-mode)

;; https://www.flycheck.org/en/latest/user/installation.html
(use-package flycheck
  :custom
  (flycheck-global-modes '(not c-mode c++-mode rust-mode))
  :config
  (global-flycheck-mode 1))

;; https://github.com/lassik/emacs-format-all-the-code
;; https://clang.llvm.org/docs/ClangFormat.html
;; https://github.com/patrickvane/shfmt
(use-package format-all
  :commands
  format-all-mode
  :config
  (setq-default
   format-all-formatters
   '(("C" (clang-format
	   "--style"
	   "{BasedOnStyle: GNU, ColumnLimit: 80, SpaceBeforeParens: Always}"))
     ("Shell" (shfmt "-ci"))))
  :hook
  (prog-mode . format-all-mode)
  (prog-mode . format-all-ensure-formatter))

;; https://github.com/haskell/haskell-mode
(use-package haskell-mode)

;; https://github.com/json-emacs/json-mode
(use-package json-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
  (add-to-list 'auto-mode-alist '("\\.jsonc\\'" . jsonc-mode)))

;; https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :custom (markdown-command "multimarkdown")
  :config
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode)))

;; https://github.com/wentasah/meson-mode
(use-package meson-mode)

;; https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :custom
  (rust-format-on-save t)
  :mode
  "\\.rs\\'")

;; https://github.com/holomorph/systemd-mode
(use-package systemd)

;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(provide 'language-packages)

;;; language-packages.el ends here
