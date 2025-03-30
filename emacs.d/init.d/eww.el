;;; Package --- eww.el
;;; Commentary:
;;; Code:

(setq-default
 eww-search-prefix "https://lite.duckduckgo.com/lite?q="
 shr-width 70)

(defun eww-add-bookmark ()
  "Bookmark the current page."
  (interactive nil eww-mode)
  (eww-read-bookmarks)
  (dolist (bookmark eww-bookmarks)
    (when (equal (plist-get eww-data :url)
		 (plist-get bookmark :url))
      (user-error "Already bookmarked")))
  (when (y-or-n-p "Bookmark this page?")
    (let ((title (replace-regexp-in-string
		  "[\n\t\r]" " "
		  (plist-get eww-data :title))))
      (setq title (replace-regexp-in-string
		   "\\` +\\| +\\'" "" title))
      (push (list :title title
		  :url (plist-get eww-data :url)) eww-bookmarks))
    (eww-write-bookmarks)
    (message "Bookmarked %s (%s)"
	     (plist-get eww-data :url)
	     (plist-get eww-data :title))))

(global-set-key (kbd "C-c d") 'eww-add-bookmark)

(defun eww-new-buffer ()
  "Open a new eww buffer."
  (interactive)
  (let ((url (read-from-minibuffer "Enter URL or keywords: ")))
    (switch-to-buffer (generate-new-buffer "*eww*"))
    (eww-mode)
    (eww url)))

(global-set-key (kbd "C-c t") 'eww-new-buffer)

(defun eww-rename-buffer-to-title ()
  "Rename the current `eww` buffer to the current page's title."
  (interactive)
  (let ((title (plist-get eww-data :title)))
    (when title
      (rename-buffer (format "*eww: %s*" title) t))))

(add-hook 'eww-after-render-hook 'eww-rename-buffer-to-title)

(provide 'eww)

;;; eww.el ends here
