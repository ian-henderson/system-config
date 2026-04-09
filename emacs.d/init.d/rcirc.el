;;; Package --- rcirc.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "init.el" alist)

(global-set-key-list '(("C-c i" . rcirc)))

(let ((full-name (getenv "LIBERA_FULL_NAME"))
      (password (getenv "LIBERA_PASSWORD"))
      (username (getenv "LIBERA_USERNAME")))
  (setq-default
   rcirc-authinfo (list (list "libera" 'sasl username password))
   rcirc-default-full-name full-name
   rcirc-default-nick username
   rcirc-default-user-name username
   rcirc-server-alist (list
                       (list "irc.libera.chat"
                             :channels '("##math"
                                         "##politics"
                                         "##statistics"
                                         ;; "#c"
                                         "#dbd"
                                         "#emacs"
                                         ;; "#finance"
                                         "#fsf"
                                         "#guix"
                                         "#libera"
                                         "#libreplanet"
                                         "#linux"
                                         ;; "#python"
                                         "#systemcrafters"
                                         )
                             :encryption 'tls
                             :nick username
                             :port 6697))))

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
