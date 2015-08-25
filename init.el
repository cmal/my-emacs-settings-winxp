;;; -*- coding: utf-8 -*-
;;; This is the emacs init.el file for my Windows XP
;;; 先设置HKCU\SOFTWARE\GNU\Emacs\HOME
;;(setq-default load-path (cons "~/.emacs.d/" load-path))

;; org-settings.el
(load-file "~/.emacs.d/org-settings.el")

;; ====设置GUI属性====
;;字体
(load-file "~/.emacs.d/font-settings.el")

;; Ctrl+滚轮缩放
;; 默认为 C-x C-+ 和 C-x C--
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; 默认窗口大小
(setq-default default-frame-alist
      '((height . 30) (width . 80) (menu-bar-lines . 20) (tool-bar-lines . 0)))

;; ====gui====
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
;(set-fringe-mode '(0 . 0))

;; 设置bookmark存储文件 
(setq-default bookmark-default-file "~/.emacs.d/bookmarks")

;; emacs-server
(setq-default server-auth-dir "E:/emacs-server")
(server-start)

;; 逐行滚动
(global-set-key (kbd "M-p") 'scroll-down-line)
(global-set-key (kbd "M-n") 'scroll-up-line)

;; 默认开启调试
(setq-default debug-on-error t)

;; 英文环境，时间等
(set-language-environment "English")

;; aspell
(add-to-list 'exec-path "D:/Program Files/Aspell/bin/")
(setq ispell-program-name "aspell")
(setq-default ispell-program-name "aspell")
;(setq ispell-personal-dictionary "C:/Emacs/lisp/textmodes")
(require 'ispell)
;(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;(global-set-key (kbd "<f8>") 'ispell-word)
;(global-set-key (kbd "C-<f8>") 'flyspell-mode)


;;; Rebind `C-x C-b' for `buffer-menu'
(global-set-key "\C-x\C-b" 'buffer-menu)


;;; emacs w3m for windows
(add-to-list 'load-path "~/.emacs.d/w3m-lisp")
(add-to-list 'exec-path "D:/Program Files/Emacs/w3m")
(require 'w3m-load)
(setq w3m-use-favicon nil)
(setq w3m-command-arguments '("-cookie" "-F"))
(setq w3m-use-cookies t)
(setq w3m-home-page "http://10.20.3.101/static/Krishnamurti/index.htm")


;; 中文计数
;; status bar 依次显示：
;; 字数,字符数不计空格,字符数计空格,非中文单词,中文字符和朝鲜语单词
(load-file "~/.emacs.d/word-like-count.el")
(require 'word-like-count-mode)
(global-set-key "\C-xw" 'word-like-count-mode)
(put 'narrow-to-region 'disabled nil)

;; freedom_from_the_know.txt 文件中每次narrow下一个段落，F5调用，C-F5对other window调用
(fset 'narrow-next-para
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 110 119 67108896 14 5 24 110 110] 0 "%d")) arg)))
(global-set-key (kbd "<f5>") 'narrow-next-para)
(fset 'narrow-next-para-other-window (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 111 f5 24 111] 0 "%d")) arg)))
(global-set-key (kbd "C-<f5>") 'narrow-next-para-other-window)


;; el-get -- packages manager
;; plz install el-get first; goto el-get homepage see how to install
(load-file "~/.emacs.d/el-get.el")
 
;; transpose-buffers 对调buffer
(defun transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))
(global-set-key (kbd "M-9") 'transpose-buffers)

;; undo-tree package
(undo-tree-mode t)

;; smex
(global-set-key (kbd "M-x") 'smex)

;; Standard Jedi.el setting -- python auto-complete
;; Type:
;;     M-x el-get-install RET jedi RET
;;     M-x jedi:install-server RET
;; Then open Python file.
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)


;; lisp括号逐级高亮，需要借助highlight-parentheses，autopair
(add-hook 'highlight-parentheses-mode-hook
          '(lambda ()
             (setq autopair-handle-action-fns
                   (append
                    (if autopair-handle-action-fns
                        autopair-handle-action-fns
                      '(autopair-default-handle-action))
                    '((lambda (action pair pos-before)
                        (hl-paren-color-update)))))))

(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; 显示括号匹配，光标在括号之后生效
(show-paren-mode t)


;; ==== pending ====
;; determine/check OS type
;; pending .. for merging init.el
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (message "MSWin")))
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    (message "OSX")))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "Linux"))))


;; ==== depreciated ====
;; 去掉启动界面
;;(setq-default inhibit-startup-message t)

;; Tab
;;(setq-default tab-width 4
;;      indent-tabs-mode t
;;      c-basic-offset 4)

;; yasnippet
;;(add-to-list 'load-path "~/.emacs.d/yasnippet")
;;(require 'yasnippet)
;;(yas/initialize)

;; version control
;;if window-system == w32
;;(setq-default vc-path "D:/Program Files/Git/cmd/git.exe")

;; template
;(require 'template)
;(template-initialize)

;; org-to-blog/wordpress
;;(load-file "~/.emacs.d/blog.el")

;; tramp
;;(load-file "~/.emacs.d/tramp.el") ; plz go there to change the remote dirs

;; melpa
;;(require 'package)
;;(add-to-list 'package-archives 
;;              '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; chrome edit-server
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/chrome")
;;(require 'edit-server)
;;(edit-server-start)

;; set mark on windows -- C-SPC conflicts with Sougou IM; change to M-SPC
;; -- sougou shortkey has been changed to C-,
;;(global-unset-key (kbd "C-SPC"))
;;(global-set-key (kbd "M-SPC") 'set-mark-command)
		 
