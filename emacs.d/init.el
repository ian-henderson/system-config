;;; Package --- init.el
;;; Commentary:
;;; Code:

;; MELPA (Milkypostman's Emacs Lisp Package Archive)
;; https://melpa.org
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(setq-default use-package-always-ensure t)

;; Loads el files in init.d
(let ((init-directory (expand-file-name "init.d" user-emacs-directory)))
  (when (file-directory-p init-directory)
    (dolist (file (directory-files init-directory t "\\.el$"))
      (load-file file))))

(provide 'init)

;;; init.el ends here
