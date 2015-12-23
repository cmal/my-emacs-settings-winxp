;;(set-default-font "宋体-10")
;;(set-frame-font "幼圆-13" nil t)
;;(set-frame-font "Caecilia LT Std-13" nil t)
;;(set-frame-font "浪漫雅圆-13" nil t)
;;(set-frame-font "Times New Roman-15" nil t)
;(set-frame-font "微软雅黑Monaco-10.5" nil t) ; no mono
;(set-frame-font "YaHei Mono-10" nil t) ; mono
;(set-frame-font "YaHei Consolas Hybrid-11" nil t) ; mono, 11 is good

;; ====中英文字体分别设置====
;; 判断字体在系统中是否安装
(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))
;; 按顺序找到字体列表中第一个已经安装可用的字体
;;(defvar font-list '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
;;(require 'cl)  ;; find-if is in common list package
;;(find-if #'qiang-font-existsp font-list)
;; 产生带font-size信息的font描述文本
(defun qiang-make-font-string (font-name font-size)
  (if (and (stringp font-size)
	   (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s%s" font-name font-size)))
;; 自动设置字体函数
(defun qiang-set-font (english-fonts
		       english-font-size
		       chinese-fonts
		       &optional chinese-font-size)
       "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
       (require 'cl)
       (let ((en-font (qiang-make-font-string
		       (find-if #'qiang-font-existsp english-fonts)
		       english-font-size))
	     (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
				 :size chinese-font-size)))
	 ;; set the default English font
	 ;; The following two methods cannot make the font setting work in new frames.
	 ;; (set-default-font "Consolas:pixelsize=18")
	 ;; (add-to-list "default-frame-alist '(font . "Consolas:pixelsize=18"))
	 ;; We have to use set-face-attribute
	 (message "Set English Font to %s" en-font)
	 (set-face-attribute
	  'default nil :font en-font
;	  :slant 'italic
	  ) ;; should change: if Caecilia LT Std, then italic
	 ;; Set Chinese font
	 ;; Do not use 'unicode charset, it will cause the English font setting invalid
	 (message "Set Chinese Font to %s" zh-font)
	 (dolist (charset '(kana han symbol cjk-misc bopomofo))
	   (set-fontset-font (frame-parameter nil 'font)
			     charset
			     zh-font))
	 ))

;; 设置字体
(qiang-set-font
 '(
;   "Caecilia LT Std"
   "Consolas"
   "Monaco"
;;   "Tahoma"
   "DejaVu Sans Mono"
   "Monospace"
   "Courier New")
 ":pixelsize=18"
   '(
;;     "华文细黑"
;;     "微软雅黑"
;;     "幼圆"
     "楷体_GB2312"
;;     "文泉驿等宽微米黑"
;;     "黑体"
;;     "新宋体"
;;     "宋体"
     ))  ;; 中文字体名请用(x-select-font nil t)查看
