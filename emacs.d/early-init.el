;;; Package --- early-init.el
;;; Commentary:
;;; Code:

(defun global-set-key-list (alist)
  "Set global keybindings.  ALIST: list of key and function pairs."
  (dolist (pair alist)
    (global-set-key (kbd (car pair)) (cdr pair))))

;; Loads el files in early-init.d
(let ((init-directory (expand-file-name "early-init.d" user-emacs-directory)))
  (when (file-directory-p init-directory)
    (dolist (file (directory-files init-directory t "\\.el$"))
      (load-file file))))

(provide 'early-init)

;;; early-init.el ends here
