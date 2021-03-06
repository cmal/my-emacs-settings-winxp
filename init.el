;;; -*- coding: utf-8 -*-
;;; This is the emacs init.el file for my Windows XP
;;; 先设置HKCU\SOFTWARE\GNU\Emacs\HOME
;;(setq-default load-path (cons "~/.emacs.d/" load-path))
;; 英文环境，时间等
(set-language-environment "English")

;; el-get -- packages manager
;; plz install el-get first; goto el-get homepage see how to install
(load-file "~/.emacs.d/el-get.el")


;; melpa
(require 'package)
(add-to-list 'package-archives 
;;              '("melpa" . "http://melpa.milkbox.net/packages/") t)
              '("melpa" . "http://melpa.org/packages/") t)
;; elpy, then M-x package-install elpy
;;(add-to-list 'package-archives
;;             '("elpy" . "http://jorgenschaefer.github.io/packages/"))
(package-initialize)

;; elpy
(elpy-enable)  ;; and then M-x elpy-config RET

;; Standard Jedi.el setting -- python auto-complete
;; Type:
;;     M-x el-get-install RET jedi RET
;;     M-x jedi:install-server RET
;; Then open Python file.
;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:complete-on-dot t)



;; find-file default directory
;;(setq-default default-directory "D:/Git/org/")

;; org-settings.el
(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
;;(require 'uimage)
(load-file "~/.emacs.d/org-settings.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(cfs--current-profile-name "profile1" t)
 '(cfs--fontsize-steps (quote (2 2 2)) t)
 '(custom-enabled-themes (quote (leuven)))
 '(ledger-binary-path "D:\\emacs-tools\\ledger\\ledger.exe")
 '(ledger-reports
   (quote
    (("bal" "D:\\emacs-tools\\ledger\\ledger.exe -f \"d:/Git/ledger/licai.ledger\" bal")
     ("reg" "D:\\emacs-tools\\ledger\\ledger.exe -f %(ledger-file) reg")
     ("payee" "D:\\emacs-tools\\ledger\\ledger.exe -f %(ledger-file) reg @%(payee)")
     ("account" "D:\\emacs-tools\\ledger\\ledger.exe -f %(ledger-file) reg %(account)")))))


;; ====设置GUI属性====
;;字体
;;(load-file "~/.emacs.d/font-settings.el")
(require 'chinese-fonts-setup)

;; Ctrl+滚轮缩放
;; 默认为 C-x C-+ 和 C-x C--
;(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
;(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'cfs-increase-fontsize)
(global-set-key (kbd "<C-wheel-down>") 'cfs-decrease-fontsize)


;; 默认窗口大小
(setq-default default-frame-alist
      '((height . 40) (width . 84) (menu-bar-lines . 20) (tool-bar-lines . 0)))

;; ====gui====
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
;(set-fringe-mode '(0 . 0))
;(set-background-color "#F9F9F5")
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

;; ;; aspell
;; (add-to-list 'exec-path "D:/Program Files/Aspell/bin/")
;; (setq ispell-program-name "aspell")
;; (setq-default ispell-program-name "aspell")
;; ;(setq ispell-personal-dictionary "C:/Emacs/lisp/textmodes")
;; (require 'ispell)
;; ;(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; ;(global-set-key (kbd "<f8>") 'ispell-word)
;; ;(global-set-key (kbd "C-<f8>") 'flyspell-mode)


;;; Rebind `C-x C-b' for `buffer-menu'
;;(global-set-key "\C-x\C-b" 'buffer-menu)


;;; emacs w3m for windows
(add-to-list 'load-path "~/.emacs.d/w3m-lisp")
(add-to-list 'exec-path "D:/Program Files/Emacs/w3m")
(require 'w3m-load)
(setq w3m-use-favicon nil)
(setq w3m-command-arguments '("-cookie" "-F"))
(setq w3m-use-cookies t)
(setq w3m-home-page "http://10.20.3.101/static/Krishnamurti/index.htm")


(put 'narrow-to-region 'disabled nil)


;; freedom_from_the_know.txt 文件中每次narrow下一个段落，F5调用，C-F5对other window调用
(fset 'narrow-next-para
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 110 119 67108896 14 5 24 110 110] 0 "%d")) arg)))
(global-set-key (kbd "<f5>") 'narrow-next-para)
(fset 'narrow-next-para-other-window (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 111 f5 24 111] 0 "%d")) arg)))
(global-set-key (kbd "C-<f5>") 'narrow-next-para-other-window)

 
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
(global-set-key (kbd "C-;") 'transpose-buffers)

;; undo-tree package
(undo-tree-mode t)

;; smex
(global-set-key (kbd "M-x") 'smex)


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

;; 美化显示符号（elisp），比如lambda会显示为λ
;;(prettify-symbols-mode)
;;(global-prettify-symbols-mode 1)

;; org 折行, disable org C-e, C-a
(eval-after-load 'org
  (progn
    (define-key org-mode-map (kbd "C-e") nil)
    (define-key org-mode-map (kbd "C-a") nil)))
;;(setq truncate-partial-width-windows nil)
;;(add-hook 'org-mode-hook (lambda () (setq truncate-lines t)))
(add-hook 'org-mode-hook (lambda () (toggle-truncate-lines nil)))



;; org-mode export to latex CJK support
;; (setq org-latex-to-pdf-process
;;       `("xelatex -interaction nonstopmode %f"
;; 	"xelatex -interaction nonstopmode %f"))
;; (add-to-list 'org-export-latex-classes
;; 	     '("cn-article"
;; 	       "\\documentclass[10pt,a4paper]{article}
;; \\usepackage{graphicx}
;; \\usepackage{xeCJK}
;; \\title{}"))

;; ==== pending ====
;; determine/check OS type
;; pending .. for merging init.el
;; (cond
;;  ((string-equal system-type "windows-nt") ; Microsoft Windows
;;   (progn
;;     (message "MSWin")))
;;  ((string-equal system-type "darwin") ; Mac OS X
;;   (progn
;;     (message "OSX")))
;;  ((string-equal system-type "gnu/linux") ; linux
;;   (progn
;;     (message "Linux"))))


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

; chrome edit-server
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/chrome")
;;(require 'edit-server)
;;(edit-server-start)

;; set mark on windows -- C-SPC conflicts with Sougou IM; change to M-SPC
;; -- sougou shortkey has been changed to C-,
;;(global-unset-key (kbd "C-SPC"))
;;(global-set-key (kbd "M-SPC") 'set-mark-command)

(load-file "~/.emacs.d/site-lisp/window-numbering.el")
(require 'window-numbering)
(window-numbering-mode 1)

(load-file "~/.emacs.d/site-lisp/unicad.el")
(require 'unicad)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;(add-to-list 'load-path "~/.emacs.d/site-lisp/python/")
;(require 'django-html-mode)
;(require 'django-mode)

(load-file "~/.emacs.d/site-lisp/web-mode.el")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-anzu-mode +1)

(require 'helm-config)
(helm-mode 1)

(setq-default magit-git-executable "D:/Program Files/Git/bin/git")
(require 'magit)
;;(setenv "GIT_ASKPASS" "git-gui--askpass")

;; powerline 不方便定制
;;(require 'powerline)
;;(powerline-default-theme)


;; 中文计数
;; status bar 依次显示：
;; 字数,字符数不计空格,字符数计空格,非中文单词,中文字符和朝鲜语单词
;; (load-file "~/.emacs.d/word-like-count.el")
;; (require 'word-like-count-mode)
;; (global-set-key "\C-xw" 'word-like-count-mode)
;; !!! 性能问题
(load-file "~/.emacs.d/chinese-count.el")
(autoload 'chinese-count-mode "chinese-count-mode")
(global-set-key "\C-xw" 'chinese-count-mode)

;; clock on mode line
(display-time-mode 1)

;让Emacs可以直接打开和显示图片
;(setq auto-image-file-mode t)

;; 全屏 F11
(toggle-frame-fullscreen)


;保存上次emacs关闭时的状态
;; (load "desktop")
;; (desktop-load-default)
;; (desktop-read)
(desktop-save-mode 1)

(pyvenv-activate "D:/virtualenv-django/Scripts/activate")


;;ledger mode
(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
;;(add-to-list 'load-path
;;             (expand-file-name "/path/to/ledger/source/lisp/"))
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))
;;(setq ledger-reconcile-default-commodity "RMB")
(load-file "~/.emacs.d/my-ledger.el")



(require 'multiple-cursors)
;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this) # use key-chord 'gn' instead
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this) # use key-chord 'gp' instead
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this) # use key-chord 'gd' instead
;; key-chord
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "vj" 'mc/edit-lines)
(key-chord-define-global "gd" 'mc/mark-all-symbol-like-this)
(key-chord-define-global "gn" 'mc/mark-next-like-this-symbol)
(key-chord-define-global "gp" 'mark-previous-symbol-like-this)
