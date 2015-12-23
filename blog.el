;; ====org2blog====
(setq-default load-path (cons "~/.emacs.d/org-mode/lisp/" load-path))
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;;org2blog
(setq-default load-path (cons "~/.emacs.d/org2blog/" load-path))
(require 'org2blog-autoloads)
;;org-toc
(require 'org-toc)

;; ====org-publish to github pages using jekyll====
(require 'org-publish)
(setq org-publish-project-alist
      '(("org-cmal"
          ;; Path to your org files.
          :base-directory "~/cmal.github.io/org/"
          :base-extension "org"

          ;; Path to your Jekyll project.
          :publishing-directory "~/cmal.github.io/_posts/"
          :recursive t
	  ;; this is for org-mode pre-version 8
          ;;:publishing-function org-publish-org-to-html
	  ;; this is for org-mode version 8 and on
	  :publishing-function org-html-publish-to-html
          :headline-levels 4 
          :html-extension "html"
          :body-only t ;; Only export section between <body> </body>
    )
    ("org-static-cmal"
          :base-directory "~/cmal.github.io/org/"
          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
          :publishing-directory "~/cmal.github.io/assets/"
          :recursive t
          :publishing-function org-publish-attachment)
    ("github" :components ("org-cmal" "org-static-cmal"))
))


;; ====发表wordpress====
(load-file "~/.emacs.d/xml-rpc.el")
(load-file "~/.emacs.d/wordpress.el")
(define-key global-map "\C-cw" 'org2blog/wp-mode) ;; 快捷进入org2blog/wp-mode模式
(define-key global-map "\C-cn" 'org2blog/wp-new-entry) ;; 快捷建立新的页面
(define-key global-map "\C-cr" 'org2blog/wp-delete-entry) ;; 快捷删除文章（看org2blog的README，有说明）
(define-key global-map "\C-cR" 'org2blog/wp-delete-page) ;; 同上，快捷删除页面
;; C-c p发布文章
;; C-c P发布页面
;; C-c d发布文章为草稿
;; C-c D发布页面为草稿
;; C-u M-x org2blog/wp-post-buffer RET

