#lang racket

(require xml)
(require "../components.rkt")

(page-template "ShaiyaJ::Blog" 
            `(  (h1 "Blog")
                (p "If you like my blog you can " (a ((href "")) "subscribe via RSS") "!") 

                (table  (tr (th "Title") (th "Category") (th "Posted"))
                        ,())
                
                (p "If you want more blogs to read, here are my " (a ((href "/recommended")) "recommendations") "!"))
