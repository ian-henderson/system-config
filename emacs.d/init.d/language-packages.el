;;; Package --- language-packages.el
;;; Commentary:
;;; Code:

;; https://github.com/Malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :hook
  ((emacs-lisp-mode lisp-mode scheme-mode) . aggressive-indent-mode))

;; https://joaotavora.github.io/eglot
(use-package eglot
  :custom
  (eglot-server-programs
   '((c-mode          . ("ccls"))
     (c++-mode        . ("ccls"))
     (java-mode       . ("jdtls"))
     (python-mode     . ("pylsp"))
     (typescript-mode . ("typescript-language-server" "--stdio"))
     (rust-mode       . ("rust-analyzer"))))
  (eglot-workspace-configuration
   '(:pylsp (:plugins (:black (:enabled t)))))
  :config
  (define-key eglot-mode-map (kbd "C-c e r") 'eglot-rename)
  (add-hook 'before-save-hook 'eglot-format-buffer)
  (mapc (lambda (mode)
	  (add-hook (intern (format "%s-hook" mode)) #'eglot-ensure))
	'(c-mode c++-mode java-mode python-mode typescript-mode rust-mode)))

;; https://github.com/yveszoundi/eglot-java
(use-package eglot-java
  :after eglot
  :config
  (let ((eglot-java-keys
         '(("n" . eglot-java-file-new)
           ("x" . eglot-java-run-main)
           ("t" . eglot-java-run-test)
           ("N" . eglot-java-project-new)
           ("T" . eglot-java-project-build-task)
           ("R" . eglot-java-project-build-refresh))))
    (dolist (pair eglot-java-keys)
      (define-key eglot-java-mode-map
		  (kbd (concat "C-c j " (car pair)))
		  (cdr pair))))
  :hook
  (java-mode . eglot-java-mode))

;; https://github.com/wwwjfy/emacs-fish
(use-package fish-mode)

;; https://www.flycheck.org/en/latest/user/installation.html
(use-package flycheck
  :custom
  (flycheck-global-modes '(not c-mode c++-mode rust-mode))
  :config
  (global-flycheck-mode 1))

;; https://github.com/lassik/emacs-format-all-the-code
;; https://clang.llvm.org/docs/ClangFormatStyleOptions.html
;; https://github.com/patrickvane/shfmt
(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :custom
  (format-all-formatters '(("Shell" (shfmt "-ci")))))

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

(use-package nxml-mode
  :ensure nil ; (built-in)
  :custom (nxml-slash-auto-complete-flag t))

;; https://github.com/emacs-php/php-mode
(use-package php-mode)

;; https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :custom (rust-format-on-save t)
  :mode "\\.rs\\'")

;; https://github.com/holomorph/systemd-mode
(use-package systemd)

(use-package typescript-mode
  :hook (js-mode . typescript-mode))

;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :init
  (mapc (lambda (s)
	  (add-to-list 'auto-mode-alist (cons s 'yaml-mode)))
	'("\\.yml\\'" "\\.yaml\\'" "\\.clang-format\\'" "\\clang-format\\'")))

(provide 'language-packages)

;;; language-packages.el ends here
