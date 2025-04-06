;;; Package --- utils.el
;;; Commentary:
;;; Code:

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
