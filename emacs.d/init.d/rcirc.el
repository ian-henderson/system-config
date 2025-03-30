;;; Package --- rcirc.el
;;; Commentary:
;;; Code:

;; LIBERA_USERNAME and LIBERA_PASSWORD are set in ~/.profile

(setq-default
 rcirc-authinfo
 `(("libera" nickserv ,(getenv "LIBERA_USERNAME") ,(getenv "LIBERA_PASSWORD")))
 rcirc-server-alist
 `(("irc.libera.chat"
    :channels ("##politics"
               "#c"
               "#cs"
               "#emacs"
               "#hacksoc"
               "#linux"
               "#networking"
               "#nixos"
               "#python"
               "#systemcrafters")
    :encryption tls
    :nick ,(getenv "LIBERA_USERNAME")
    :port 6697)))

(global-set-key (kbd "C-c i") 'irc)

(provide 'rcirc)

;;; rcirc.el ends here
