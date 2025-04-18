;;; Package --- early-init.el
;;; Commentary:
;;; Code:

(defun global-set-key-list (alist)
  "Set global keybindings.  ALIST: list of key and function pairs."
  (dolist (pair alist)
    (global-set-key (kbd (car pair)) (cdr pair))))

;; Loads el files in early-init.d
(let ((early-init-d (expand-file-name "early-init.d" user-emacs-directory)))
  (when (file-directory-p early-init-d)
    (mapc #'load-file (directory-files early-init-d t "\\.el$"))))

(provide 'early-init)

;;; early-init.el ends here
