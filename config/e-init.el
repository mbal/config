(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)


(mapc #'require
      '(e-ui
         e-evil
         e-acconfig
         e-lispbox
         e-erlang))

(defun autocompile nil
  "compile itself, if ~/.emacs"
  (interactive)
  (require 'bytecomp)
  (if (string= (buffer-file-name)
               (expand-file-name (concat default-directory ".emacs")))
        (byte-compile-file (buffer-file-name))))

(add-hook 'after-save-hook 'autocompile)

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


(defun dos2unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t)
    (replace-match "")))
(defun unix2dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t)
    (replace-match "\r\n")))

(setq backup-directory-alist '(("." . "~/.saves")))

(cd "C:\\Users\\Utente")

;;; miscellaneous org-mode settings
(setq org-log-done 'time)
;;org-mode binding with evil

(setq org-src-fontify-natively t)

(provide 'e-init)
