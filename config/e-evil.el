(require 'undo-tree)
(global-undo-tree-mode)

(require 'e-util)
(require 'evil-leader)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'open-dotemacs
  "1" 'rotate-theme
  "bk" 'buff-kill)

(require 'evil)
(evil-mode 1)
(setq evil-intercept-esc 'always)

(evil-ex-define-cmd "html" 'org-export-as-html-and-open)
(evil-ex-define-cmd "bk[ill]" 'buff-kill)

(defun minibuffer-keyboard-quit ()
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
      (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape]
  'minibuffer-keyboard-quit) 
(define-key minibuffer-local-completion-map [escape]
  'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape]
  'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape]
  'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

(provide 'e-evil)
