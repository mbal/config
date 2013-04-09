(require 'auto-complete)
(require 'auto-complete-config)
(setq ac-auto-start nil)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-1.3.1/dict")
(ac-config-default)

(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'slime-repl-mode))

(require 'ac-python)

(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                           (auto-complete-mode 1))))
(real-global-auto-complete-mode t)

(require 'evil)
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

(defun smart-tab2 (arg)
  (interactive "P")
  (let ((current-line (buffer-substring (line-beginning-position) (point))))
    (if (string-match "^[:space:]*$" current-line)
        (indent-according-to-mode)
      (auto-complete))))

(require 'e-func)
(macro/bind-keys-after-load 'auto-complete 'insert ac-mode-map
                            (kbd "TAB") 'smart-tab2)

(provide 'e-acconfig)
