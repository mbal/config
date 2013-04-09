;; little function to rotate theme, chosing from the list *custom-themes*
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

(defun open-dotemacs ()
  (interactive)
  (find-file "~/.emacs"))

(defun buff-kill ()
  (interactive)
  (kill-buffer)); (current-buffer)))

(provide 'e-util)
