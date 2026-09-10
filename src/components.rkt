#lang racket
(provide (all-defined-out))

(require xml)

(define (component-navbar) '(nav (a) (a)))
(define (component-footer) '(footer (p "The footer is work in progress...")
                             (p "Copyright 2026")))

(define (page-template page-title page-content) (xexpr->string
    `(html
        (head
            (title ,page-title)
            (link ((rel "icon") (href "https://avatars.githubusercontent.com/u/93013772") (type "image/png")))
            (link ((rel "stylesheet") (href "/global.css")))
            (link ((rel "alternate") (type "application/rss") (href "/blog/feed.rss"))))
;            (meta)) TODO
        (body
            ,(component-navbar)
            (main ,@page-content)
            ,(component-footer)))))
