;;;; e-lispbox
;;; adapted from lispbox found on cliki, made it more evil
;;; so, it should actually be named evil-slime.el, or blob.el
(defvar LISPBOX_HOME "C:\\PPrograms\\lispbox-0.7")

(defun lispbox-list-to-filename (lst)
  (apply 'concat
         (maplist 
          (lambda (cns)
            (if (cdr cns) 
                (file-name-as-directory (car cns)) 
              (car cns)))
          lst)))

(defun lispbox-file (rst)
  (concat 
   (file-name-as-directory
    (expand-file-name
     (or LISPBOX_HOME
         (file-name-directory load-file-name))))
   rst))

(defun lispbox-find-lisps ()
  (dolist (file (file-expand-wildcards (lispbox-file "*/lispbox-register.el")))
    (load file)))

(setenv "CCL_DEFAULT_DIRECTORY" (lispbox-file "ccl"))

(require 'slime)

(load "c:/users/utente/quicklisp/slime-helper.el")

(setq slime-auto-connect 'always)
(slime-setup '(slime-fancy 
               slime-asdf))

(lispbox-find-lisps)

;;; starts slime when slime-mode is activated
(add-hook 'slime-mode-hook 'start-slime)
;;; add some evil keybindings
(add-hook 'slime-mode-hook (lambda () (setup-evil-slime)))
;(setq inferior-lisp-program "sbcl")

(defun setup-evil-slime () ;; aka setup-blob
  (require 'evil-leader)
  (evil-leader/set-key
    "c" 'save-compile
    "a" 'slime-pprint-eval-last-expression))

(defun save-compile ()
  (interactive)
  (basic-save-buffer)
  (slime-compile-file))

(defun start-slime ()
  (let ((prev-buffer (current-buffer)))
    (unless (slime-connected-p)
      (save-excursion (slime))
      (windmove-up)
      (enlarge-window 8)
      (switch-to-buffer prev-buffer))))

(defun macro-expand ()
  "Calls slime-macroexpand-1(-inplace). Tries to DWIM,
meaning that it expands inplace when gets called 
from a *slime-macroexpansion* bUffer"
  (interactive)
  (save-excursion
    (beginning-of-sexp)
    (backward-char)
    (if (string= (buffer-name) "*slime-macroexpansion*")
        (slime-macroexpand-1-inplace)
      (slime-macroexpand-1))))

(defun special-undo ()
  (interactive)
  (if (string= (buffer-name) "*slime-macroexpansion*")
      (slime-macroexpand-undo)
    (undo-tree-undo)))

;(ad-enable-advice 'undo-tree-undo 'around 'special-undo)

(require 'e-func)

(macro/bind-keys-after-load 'slime 'normal lisp-mode-map
                            "!" 'macro-expand
                            "K" 'slime-documentation-lookup
                            "u" 'special-undo)


;;; ok, this version below should work, but it doesn't. I believe the problem
;;; is that u is bound even to undo-tree. So, what is the order of resolution
;;; for keymaps?
;(evil-define-key 'normal slime-macroexpansion-minor-mode-map "u" 'slime-macroexpand-undo)

(provide 'e-lispbox)
