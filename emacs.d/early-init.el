;;; Package --- early-init.el
;;; Commentary:
;;; Code:

(defun global-set-key-list (list)
  "Set global keybindings. LIST: list of keymapping and function pairs."
  (dolist (binding list)
    (global-set-key (kbd (car binding)) (cdr binding))))

;; Loads el files in early-init.d
(let ((init-directory (expand-file-name "early-init.d" user-emacs-directory)))
  (when (file-directory-p init-directory)
    (dolist (file (directory-files init-directory t "\\.el$"))
      (load-file file))))

(provide 'early-init)

;;; early-init.el ends here
