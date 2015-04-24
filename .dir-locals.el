;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil (eval local-set-key
               (kbd "M-e")
               '(lambda ()
                  (interactive)
                  (require 'magit)
                  (let ((compile-command (format "cd %s ; elm make"
                                                 (magit-get-top-dir))))
                    (save-buffer)
                    (compile compile-command))))))
