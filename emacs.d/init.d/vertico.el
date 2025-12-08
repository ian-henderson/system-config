;;; Package --- vertico.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; https://github.com/minad/vertico
(use-package vertico :init (vertico-mode t))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist :init (savehist-mode t))

(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
   	      ("RET" . vertico-directory-enter)
   	      ;; ("DEL" . vertico-directory-delete-char) ; doesn't seem to work
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

;; https://github.com/minad/marginalia
(use-package marginalia :init (marginalia-mode t))

(provide 'vertico)

;;; vertico.el ends here
