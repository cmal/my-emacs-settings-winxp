
;; ====TRAMP====
;; (require 'tramp)
;; (setq-default tramp-default-method "plink")
;; (setq-default tramp-completion-reread-directory-timeout 10)
;; (global-set-key "\C-coa" (lambda ()
;; 			  (interactive)
;; 			  (find-file
;; 			   (read-file-name
;; 			    "Find Tramp file: "
;; 			    "/plink:cmal@zhaoyutekimbp.mshome.net:~/org/emacs.org"))))
;; ;;			    "/plink:cmal@zhaoyutekimbp:~/org/emacs.org"))))

;; (global-set-key "\C-cob" (lambda ()
;; 			  (interactive)
;; 			  (find-file
;; 			   (read-file-name
;; 			    "Find Tramp file: "
;; 			    "/plink:cmal@192.168.100.133:~/org/emacs.org"))))
