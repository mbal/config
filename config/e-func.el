(defun group (lst n)
  "Create groups of size `n` from the given list.
This function is often useful in macros, to create
plist from &rest arguments.
 (group '(1 2) 2) => ((1 2))
 (group '(1 2 3) 2) => ((1 2) (3))
 (group '(1 2) 3) => ((1 2))
It's often useful in macros, to create plist from &rest arguments"
  (labels ((helper (src acc)
                   (let ((rst (nthcdr n src)))
                     (cond
                      ((null rst) (nreverse (cons src acc)))
                      ((consp rst) (helper rst (cons (subseq src 0 n) acc)))
                      (t (nreverse (cons rst acc)))))))
    (if lst (helper lst '()) '())))

(defun mloop (keycmds acc)
  (cond
    ((null keycmds) (nreverse acc))
    (t (mloop (cdr keycmds) (cons (car keycmds) acc)))))

(require 'evil)

(defmacro macro/bind-keys-after-load (what mode mode-map &rest keys)
  " Calls evil-define-key after loading `what', in evil's `mode' and
infects the `mode-map'."
  `(eval-after-load ,what 
     '(progn
        (evil-define-key ,mode ,mode-map
          ,@(reduce #'append (group keys 2)))))) ; => flatten list

(provide 'e-func)
