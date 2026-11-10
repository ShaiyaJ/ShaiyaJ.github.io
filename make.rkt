#lang racket

(define (process-rkt-file path) 
    (read (open-input-string (with-output-to-string
        (thunk (dynamic-require path #f))))))

; Setting up docs directory
(if (eq? (directory-exists? "docs") #f)
    (make-directory "docs")
    (for/list ([f (in-directory "docs")]) 
        (delete-directory/files f)))

; Process function
(define (process-file f) 
    (let ([target (string-replace (string-replace (path->string f) "src/pages" "docs") ".rkt" "")])

        (cond 
            ; Handle directories
            [(directory-exists? f)                      (make-directory target)]
            ; Handle files that end in rkt
            [(bytes=? (filename-extension f) #"rkt")    (display-to-file (process-rkt-file f) target)]
;            [(bytes=? (filename-extension f) #"rkt")    (display-to-file (display-to-string (process-command "/bin/racket" (path->string f))) target)] 
            ; Handle files that don't end in rkt
            [#t                                         (copy-file f target)]))
    f)

; Processing every file/directory
(for/list ([f (in-directory "src/pages")]) 
    (process-file f))
