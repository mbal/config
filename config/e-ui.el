(tool-bar-mode -1)

(setq inhibit-startup-message t)

(fset 'yes-or-no-p 'y-or-n-p) ;;change "yes or n" prompt to `y or n'

(setq frame-title-format
      '("" (:eval (if (buffer-file-name)
                      (replace-regexp-in-string "c:/Users/Utente" "~"
                                                (buffer-file-name))
                    (buffer-name))
                  "%b")
        " - emacs " emacs-version))

(show-paren-mode t) ;; highlight matching parenthesis

;; turn off hideous bell sounds
(setq ring-bell-function 'ignore)

;; yeah, linum-mode sucks, it's super slow.
;; At least show (line, column) in the status bar.
(setq column-number-mode t)
(setq line-number-mode t)

;; vim-like. It's not perfect, but neither the other option is,
;; so let's keep the one which is more useful
(setq sentence-end-double-space nil) 

;; tab settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(load-theme 'wombat)

(provide 'e-ui)
