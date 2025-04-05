;;; Package --- custom.el
;;; Commentary:
;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes 'nil)
 '(git-gutter:hide-gutter t)
 '(git-gutter:update-interval 2)
 '(package-selected-packages
   '(auto-package-update benchmark-init circadian company dashboard
			 evil-collection exec-path-from-shell flycheck
			 format-all git-gutter magit markdown-mode
			 modus-themes moe-theme projectile
			 rainbow-delimiters rust-mode vertico vterm
			 yaml-mode)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'custom)

;;; custom.el ends here
