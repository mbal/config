(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c56fd34f8f404e6e9e6f226c6ce2d170595acc001741644d22b49e457e3cd497"
     "998e84b018da1d7f887f39d71ff7222d68f08d694fe0a6978652fb5a447bdcd2"
     "1760322f987b57884e38f4076ac586c27566a1d7ed421b67843c8c98a1501e3a"
     "72cc9ae08503b8e977801c6d6ec17043b55313cda34bcf0e6921f2f04cf2da56"
     "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c"
     "d2622a2a2966905a5237b54f35996ca6fda2f79a9253d44793cfe31079e3c92b"
     default)))
 '(evil-want-C-w-in-emacs-state t)
 '(font-lock-maximum-decoration (quote ((erlang-mode . 3)))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "C:/Program Files/erl5.9.3.1/lib/tools-2.6.8/emacs")
(setq erlang-root-dir "C:/Program Files/erl5.9.3.1")
(setq exec-path (cons "C:/Program Files/erl5.9.3.1/bin"
                      exec-path))
(require 'erlang-start)

(require 'evil)
(evil-mode 1)

(require 'ack)

(require 'undo-tree)
(global-undo-tree-mode)

(load-theme 'wombat)

(require 'evil-leader)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'open-dotemacs
  "1" 'rotate-theme
  )

(defun open-dotemacs ()
  (interactive)
  (find-file "~/.emacs"))

;;ESC does the right thing (TM) (quits everything)
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

(defun smart-tab (arg)
  "That was difficult. Mimick `clever_tab` from VIM. It's
minibuffer compliant: it acts as usual in the minibuffer (both
opened with M-x and with :, for evil).
Otherwise, if the current line is empty, it tries to indent it,
according to the mode. If there's some text, it tries the
completion, with the function completion-at-point (for programming)"
  (interactive "P")
  (if (minibufferp)
      (if (string-match "^:" (minibuffer-prompt))
          (evil-ex-run-completion-at-point)
        (minibuffer-complete))
    (let ((current-line (buffer-substring (line-beginning-position) (point))))
      (if (string-match "^[:space:]*$" current-line)
          (indent-according-to-mode)
        (completion-at-point)))))

(global-set-key [tab] 'smart-tab)


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

(show-paren-mode t) ;; hightlight matching parenthesis

(defconst *custom-themes* '(wombat
                            occidental
                            solarized-light
                            solarized-dark))

(defvar *index* 0)

(defun rotate-theme ()
  (interactive)
  (setq *index* (% (+ 1 *index*)
                   (length *custom-themes*)))
  (let ((next-theme (nth *index* *custom-themes*)))
    (print next-theme)
    (load-theme next-theme t)))

;;vim-like. It's not perfect, but neither the other option is, so let's keep the one which is more useful
(setq sentence-end-double-space nil) 

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

(setq org-src-fontify-natively t)
