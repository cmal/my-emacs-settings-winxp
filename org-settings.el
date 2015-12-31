(require 'org-freemind)
(require 'org-special-blocks)


;; ====org-agenda====
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(setq-default org-clock-persist 'history)
;;(org-clock-persistence-insinuate)
(setq-default org-clock-done 'time)
(setq-default org-use-fast-todo-selection t)
(setq-default org-agenda-ndays 1)
(setq-default org-agenda-todo-ignore-scheduled t)
(setq-default org-agenda-todo-ignore-deadlines t)


;; === org editing ===
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'org-mode-hook (lambda () (define-key org-mode-map (kbd "C-c C-'") 'org-edit-special)))
(add-hook 'org-src-mode-hook
	  (lambda () (define-key org-src-mode-map (kbd "C-c C-'")
		       'org-edit-src-exit)))
;; === org table ===
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq org-calc-default-modes
		  '(calc-internal-prec 20 calc-float-format
				       (float 20)
				       calc-angle-mode deg
				       calc-prefer-frac nil
				       calc-symbolic-mode nil
				       calc-date-format (YYYY "-" MM "-" DD " " Www
							      (" " hh ":" mm))
				       calc-display-working-message t))))
