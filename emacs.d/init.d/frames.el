;;; Package --- frames.el
;;; Commentary:
;;; Code:

(declare-function global-set-key-list "init.el" alist)

(defvar frames-keybindings-list
  (append
   '(("C-c n" . tab-rename)
     ("M-p"   . tab-bar-switch-to-prev-tab)
     ("M-n"   . tab-bar-switch-to-next-tab)
     ("M-P"   . tab-bar-move-tab-backward)
     ("M-N"   . tab-bar-move-tab)
     ("M-t"   . tab-bar-new-tab)
     ("M-T"   . tab-bar-undo-close-tab)
     ("M-w"   . tab-bar-close-tab))
   ;; keybindings for M-1 through M-9
   (mapcar (lambda (i)
	     (cons (format "M-%s" i) `(lambda ()
					(interactive)
					(tab-bar-select-tab ,i))))
	   (number-sequence 1 9))))

(global-set-key-list frames-keybindings-list)

(provide 'frames)

;;; frames.el ends here
