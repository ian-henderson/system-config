;;; Package --- language-settings.el
;;; Commentary:
;;; Code:

;; ELisp
;; (setq-default lexical-binding t) ; Not sure if I need this

;; C/C++

(defun c-mode-hook-gnu ()
  "Custom C programming settings for following the Linux kernel style."
  (setq-default tab-width 8)
  (c-set-style "gnu"))

(defun c-mode-hook-linux ()
  "Custom C programming settings for following the Linux kernel style."
  (setq-default c-argdecl-indent 8
                c-basic-offset 8
                c-brace-imaginary-offset 0
                c-brace-offset 0
                c-continued-statement-offset 8
                c-indent-level 8
                c-label-offset -8
                indent-tabs-mode t
                tab-width 8)
  (c-set-style "linux"))

(add-hook 'c-mode-hook 'c-mode-hook-gnu)

;; Hideshow minor mode
(add-hook 'prog-mode-hook #'hs-minor-mode)

(defun toggle-hs-all ()
  "Toggle all blocks with Hideshow minor mode."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (hs-already-hidden-p)
        (hs-show-all)
      (hs-hide-all))))

(global-set-key (kbd "C-c H") 'toggle-hs-all)

(defun toggle-hs-block ()
  "Toggle block with Hideshow minor mode."
  (interactive)
  (if (hs-already-hidden-p)
      (hs-show-block)
    (hs-hide-block)))

(global-set-key (kbd "C-c h") 'toggle-hs-block)

(provide 'language-settings)

;;; language-settings.el ends here
