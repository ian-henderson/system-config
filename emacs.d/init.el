;;; Package --- init.el
;;; Commentary:
;;; Code:

(let ((init-directory (expand-file-name "init.d" user-emacs-directory)))
  (when (file-directory-p init-directory)
    (dolist (file (directory-files init-directory t "\\.el$"))
      (load-file file))))

(provide 'init)

;;; init.el ends here
