;;; Package --- language-packages.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; https://github.com/Malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :hook
  ((emacs-lisp-mode lisp-mode scheme-mode) . aggressive-indent-mode))

(define-minor-mode eglot-format-on-save-mode
  "Toggle Eglot automatic formatting before saving buffer."
  :global
  nil
  :lighter " EglotFmt"
  (if eglot-format-on-save-mode
      (add-hook 'before-save-hook 'eglot-format-buffer nil 'local)
    (remove-hook 'before-save-hook 'eglot-format-buffer 'local)))

;; https://joaotavora.github.io/eglot
(use-package eglot
  :config
  (define-key eglot-mode-map (kbd "C-c e f") 'eglot-format-buffer)
  (define-key eglot-mode-map (kbd "C-c e r") 'eglot-rename)
  (dolist (mode '(c c++ java python typescript rust))
    (add-hook (intern (format "%s-mode-hook" mode)) #'eglot-ensure))
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
  ;; :hook (eglot-activated . eglot-format-on-save-mode)
  )

;; https://github.com/yveszoundi/eglot-java
(use-package eglot-java
  :after
  eglot
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

;; https://www.flycheck.org/en/latest/user/installation.html
(use-package flycheck
  :custom (flycheck-global-modes '(not c-mode c++-mode rust-mode))
  :config
  (global-flycheck-mode 1))

;; https://github.com/lassik/emacs-format-all-the-code
;; https://clang.llvm.org/docs/ClangFormatStyleOptions.html
;; https://github.com/patrickvane/shfmt
(use-package format-all
  :commands
  format-all-mode
  :custom
  (format-all-formatters '(("Shell" (shfmt "-ci"))))
  :hook
  (prog-mode . format-all-mode))

;; https://github.com/haskell/haskell-mode
(use-package haskell-mode)

;; https://github.com/json-emacs/json-mode
(use-package json-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
  (add-to-list 'auto-mode-alist '("\\.jsonc\\'" . jsonc-mode)))

;; https://github.com/immerrr/lua-mode
(use-package lua-mode)

;; https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :custom
  (markdown-command "multimarkdown")
  :mode
  (("\\.markdown\\'" . gfm-mode)
   ("\\.md\\'"       . gfm-mode)
   ("\\.txt\\'"      . gfm-mode)))

;; https://github.com/wentasah/meson-mode
(use-package meson-mode)

(use-package nxml-mode
  :custom
  (nxml-slash-auto-complete-flag t)
  :ensure
  nil) ; (built-in)

;; https://github.com/emacs-php/php-mode
(use-package php-mode)

;; https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :custom
  (rust-format-on-save t)
  :mode
  "\\.rs\\'")

;; https://github.com/holomorph/systemd-mode
(use-package systemd)

(use-package typescript-mode
  :hook
  (js-mode . typescript-mode))

;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :init
  (dolist (str '("\\.yml\\'"
		 "\\.yaml\\'"
		 "\\.clang-format\\'"
		 "\\clang-format\\'"))
    (add-to-list 'auto-mode-alist (cons str 'yaml-mode))))

(provide 'language-packages)

;;; language-packages.el ends here
