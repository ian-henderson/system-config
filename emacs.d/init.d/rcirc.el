;;; Package --- rcirc.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "init.el" alist)

(global-set-key-list '(("C-c i" . rcirc)))

(setq-default
 rcirc-authinfo `(("libera" nickserv ,(getenv "LIBERA_USERNAME")
		   ,(getenv "LIBERA_PASSWORD")))
 rcirc-default-full-name (getenv "LIBERA_FULL_NAME")
 rcirc-server-alist `(("irc.libera.chat"
		       :channels ("##math" "##politics" "##statistics"
				  "#archlinux" "#c" "#emacs" "#finance" "#java"
				  "#libera" "#linux" "#python")
		       :encryption tls
		       :nick ,(getenv "LIBERA_USERNAME")
		       :port 6697)))

(add-hook 'rcirc-mode-hook
	  (lambda () (set (make-local-variable 'scroll-conservatively) 8192)))

(defun rcirc-kill-buffers ()
  "Kill all rcirc buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (when (eq major-mode 'rcirc-mode)
	(kill-buffer)))))

(provide 'rcirc)

;;; rcirc.el ends here
