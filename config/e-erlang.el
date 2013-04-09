(add-to-list 'load-path "C:/Program Files/erl5.9.3.1/lib/tools-2.6.8/emacs")
(setq erlang-root-dir "C:/Program Files/erl5.9.3.1")
(setq exec-path (cons "C:/Program Files/erl5.9.3.1/bin"
                      exec-path))
(require 'erlang-start)

(provide 'e-erlang)
