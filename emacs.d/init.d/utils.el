;;; Package --- utils.el
;;; Commentary:
;;; Code:

;; https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
  :config
  (setq-default auto-package-update-delete-old-versions t
                auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; https://github.com/dholm/benchmark-init-el
(use-package benchmark-init
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs '("LIBERA_USERNAME" "LIBERA_PASSWORD")))

;; flyspell
(require 'flyspell)
(dolist (hook '(markdown-mode-hook org-mode-hook text-mode-hook))
  (add-hook hook 'flyspell-mode))

(defun load-init-file ()
  "Reload init.el."
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))

(defun load-custom-file ()
  "Generate custom.el if one doesn't exist and load it."
  (setq custom-file (expand-file-name "init.d/custom.el" user-emacs-directory))
  (unless (file-exists-p custom-file)
    (with-temp-buffer
      (insert ";;; Package --- custom.el\n")
      (insert ";;; Commentary:\n")
      (insert ";;; Code:\n\n")
      (insert "(provide 'custom)\n\n")
      (insert ";;; custom.el ends here\n")
      (write-region (point-min) (point-max) custom-file)))
  (load custom-file))

(load-custom-file)

(provide 'utils)

;;; utils.el ends here
