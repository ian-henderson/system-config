;;; Package --- erc.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; https://www.gnu.org/software/emacs/manual/html_node/erc/index.html
;; https://www.gnu.org/software/emacs/manual/html_node/erc/Modules.html
;; https://www.gnu.org/software/emacs/manual/html_node/erc/SASL.html
;; Other libera channels:
;; #c
;; #guile
;; #linux
;; ##math
(use-package erc
  :bind
  ("C-c i" . erc-tls)
  :custom
  (erc-autojoin-channels-alist '((".*\\.libera.chat"
                                  "#emacs" "#gnome" "#guix" "#linux")))
  (erc-hide-list '("JOIN" "NICK" "PART" "QUIT"))
  (erc-interactive-display 'buffer)
  (erc-max-buffer-size 10000)
  (erc-modules '(autojoin
                 button
                 command-indicator
                 completion
                 fill
                 keep-place
                 menu
                 nicks
                 notifications
                 ring
                 sasl
                 scrolltobottom
                 services
                 sound
                 spelling
                 stamp
                 track
                 truncate))
  (erc-nick (getenv "LIBERA_USERNAME"))
  (erc-nicks-colors 'all)
  (erc-password (getenv "LIBERA_PASSWORD"))
  (erc-port 6697)
  (erc-prompt-for-password nil)
  (erc-sasl-password (getenv "LIBERA_PASSWORD"))
  (erc-sasl-user (getenv "LIBERA_USERNAME"))
  (erc-scrolltobottom-all t)
  (erc-server "irc.libera.chat")
  (erc-track-shorten-aggressively 'max)
  (erc-track-showcount t)
  (erc-user-full-name (getenv "LIBERA_FULL_NAME"))
  :config
  (require 'erc-sasl)
  (erc-autojoin-mode 1)
  (erc-services-mode -1)  ; disables nickserv, using sasl instead
  (erc-update-modules)
  :ensure nil)

(provide 'erc)

;;; erc.el ends here
