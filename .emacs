(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(evil-want-C-w-in-emacs-state t)
 '(font-lock-maximum-decoration (quote ((erlang-mode . 3)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))


(add-to-list 'load-path "~/.emacs.d/elpa/evil-1.0.0")
(add-to-list 'load-path "~/.emacs.d/elpa/ack-0.8")
(add-to-list 'load-path "~/.emacs.d/elpa/paredit-22")
(add-to-list 'load-path "~/.emacs.d/elpa/undo-tree-0.6.3")
(add-to-list 'load-path "~/.emacs.d/elpa/evil-1.0.0")
(add-to-list 'load-path "~/.emacs.d/elpa/evil-leader-0.1")
(add-to-list 'load-path "~/.emacs.d/elpa/evil-paredit-0.0.1")
(add-to-list 'load-path "~/.emacd.d/elpa/markdown-mode-1.9")

(add-to-list 'load-path "C:/Program Files/erl5.9.3.1/lib/tools-2.6.8/emacs")
(setq erlang-root-dir "C:/Program Files/erl5.9.3.1")
(setq exec-path (cons "C:/Program Files/erl5.9.3.1/bin"
                      exec-path))
(require 'erlang-start)

(require 'evil)
(evil-mode 1)
(require 'ack)

;;some leader mapping. A vimmer dream's.
(require 'evil-leader)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'open-dotemacs)

(defun open-dotemacs ()
  (interactive)
  (find-file "~/.emacs"))

;ESC does the right thing (TM) (==> quits EVERYTHING!)
(defun minibuffer-keyboard-quit ()
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(global-set-key [escape] 'evil-exit-emacs-state)


(show-paren-mode t)

;;paredit mode doesn't interact well with evil (for example C-v -- block select
;;-- doesn't work anymore), and moreover, in lisp interaction mode,
;; C-j doesn't 'eval-print-last-sexp, I've defined a simple keybinding to
;;avoid that, but it's a kludge, and evil-paredit is still young.
                                        ;(require 'evil-paredit)
                                        ;(require 'paredit)
                                        ;(autoload 'paredit-mode "paredit"
                                        ;  "minor mode for pseudo-structurally editing Lisp code." t)
                                        ;(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
                                        ;(add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)
                                        ;(add-hook 'lisp-interaction-mode-hook 'paredit-mode)
                                        ;(add-hook 'lisp-interaction-mode-hook 'evil-paredit-mode)
                                        ;(eval-after-load "paredit"
                                        ;  #'(define-key paredit-mode-map (kbd "C-j") 'eval-print-last-sexp))

(require 'undo-tree)
(global-undo-tree-mode)

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

;;some graphics-related stuff
(tool-bar-mode -1) ;;disable toolbar
(setq inhibit-startup-message t) ;;don't show gnu start screen
(fset 'yes-or-no-p 'y-or-n-p) ;;change "yes or n" prompt to `y or n'
(setq frame-title-format
      '("" (:eval (if (buffer-file-name)
                      (replace-regexp-in-string "c:/Users/Utente" "~" (buffer-file-name))
                    (buffer-name))
                  "%b")
        " - emacs " emacs-version))

(setq column-number-mode t) ;;yeah, line numbering sucks, at least, 
(setq line-number-mode t) ;;show (line, column) in the status bar

(setq ring-bell-function 'ignore)

(setq sentence-end-double-space nil) ;;vim-like. It's not perfect, but neither the other option is, so let's keep the one which is more useful

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

;;(global-linum-mode 1) ;; show line numbers ==> makes scrolling hyper-slow. does not recommed.

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)

(setq backup-directory-alist '(("." . "~/.saves")))

(cd "C:\\Users\\Utente")

;;; miscellaneous org-mode settings
(setq org-log-done 'time)
;;org-mode binding with evil
(evil-ex-define-cmd "html" 'org-export-as-html-and-open)
