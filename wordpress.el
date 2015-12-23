;;; -*- coding: utf-8 -*-
;;
;; org2blog
;;

(require 'org2blog-autoloads)
(setq org2blog/wp-blog-alist
      `(("wordpress"
         :url "http://10.20.3.101:8888/xmlrpc.php"
         :username "cmal"
         :password "89362556"
         :keep-new-lines t
         :confirm t
         :wp-code t
         :default-title nil
         :default-categories nil
         :tags-as-categories nil)))
(setq org2blog/wp-buffer-template
      "#+DATE: %s
      #+OPTIONS: toc:nil num:nil todo:nil pri:nil tags:nil ^:nil TeX:nil
      #+CATEGORY: 
      #+TAGS:
      #+PERMALINK:
      #+TITLE:
      \n")
