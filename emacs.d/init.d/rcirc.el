;;; Package --- rcirc.el
;;; Commentary:
;;; Code:

(setq-default
 rcirc-authinfo
 `(("libera" nickserv,(getenv "LIBERA_USERNAME") ,(getenv "LIBERA_PASSWORD")))
 rcirc-server-alist
 `(("irc.libera.chat"
    :channels ("##politics" "##rust" "#debian" "#emacs" "#guile" "#libera"
	       "#linux" "#lisp" "#networking" "#scheme" "#systemcrafters")
    :encryption tls
    :nick ,(getenv "LIBERA_USERNAME")
    :port 6697)))

(add-hook 'rcirc-mode-hook
	  (lambda ()
	    (set (make-local-variable 'scroll-conservatively) 8192)))

(global-set-key (kbd "C-c i") 'rcirc)

(defun kill-rcirc ()
  "Kill all rcirc buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (when (eq major-mode 'rcirc-mode)
        (kill-buffer)))))

(provide 'rcirc)

;;; rcirc.el ends here
