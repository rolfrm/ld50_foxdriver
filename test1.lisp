(load "lisp1.lisp" )

(do-times 4 (lambda () (println (quote hej))))
(map! print (list 1 2 3 4 (quote x)))
(define x (macro (&rest b) b))

(println (x))

(println (read-string "(+ 1 2)"))
(println (eval (read-string "(+ 1 2)")))

(println (type-of (cons 1 2)))
(println (type-of "13"))

(print (- (+ 5 3 ) 1))
(println (if 1 (+ 2 3.5) 3))
(println (quote (1 2 3)))
(println (cons 1 2))
(println (+ 1 2))
(println (lambda (x) x))
(define y (+ 0.33333 5.0))
(println (+ y y))
((lambda (x y) (print (+ x y))) 5.0 50.9)
(define add (lambda (x y) (+ (println x) (println y))))
(println (add 123 321))

(when t (println "unless nil"))
(unless nil (println "__unless nil_-"))
(when nil (panic "This should not happen"))
(unless t (panic "This should not happen"))
(println '(1 2 3))
(println `(1 2 ,(+ 1 3)))


(assert (= 10 (funcall + 1 9)))

(define x 4)
(set! x 9)

(begin
 (println 1)
 (println 2)
 (println x))

(assert (cons? (cons 1 2 )))

(let ((file (fopen "./test.x" "w+"))
		(data (make-vector 100 (byte 0)))
		)
  (vector-set! data 0 (byte 255))
  (vector-set! data 1 (byte 1))
  (vector-set! data 2 (byte 100))
  (println `(file:  ,file))
  (fwrite (vector-native-element-pointer data 0) 1024 1 file)
  (fclose file)
  )

(println (list '>> (lambda () 2)))

(let ((file (fopen "./test.x" "r"))
		(data (make-vector 10 (byte 0)))
		)
  
  (let ((read (lambda () (fread (vector-native-element-pointer data 0) 1 10 file)))
		  (r 0)
		  )
	 (loop (not (= 0 (set! r (read))))
		 (println r)
		 (println data)
		 )
	 )
  (fclose file)
  )

(let ((vector (make-vector 3 0)))
  (vector-set! vector 0 10)
  (vector-set! vector 1 555)
  (vector-set! vector 2 555)
  (println (list (vector-element-type vector) ': (vector-ref vector 0) (vector-ref vector 2) (vector-ref vector 1)))
  (println 'hello)
  (println (list 'vector 'pointer ': (vector-native-element-pointer vector 0)))
  (vector-resize vector 5)
  (println (list 'resized vector))
  )
(println (type-of 1))

(assert (and 1 1 2))
(assert-not (and 1 1 2 nil))
(assert-not (and nil))
(assert (and t))
(assert (and))

(assert (or 1 nil))
(assert-not (or nil nil))
(assert (or nil 1))

(assert-not (eq '(1 2 ( 3 4)) '(1 2 ( 3 4))))

(assert (equals? '(1 2 ( 3 4)) '(1 2 ( 3 4))))

(define x (cons nil nil))
(set-cdr! x (cons 2))
(set-car! x 1)

(assert (eq 0.2 .2))

(println (= 1 (car '(1 . 2))))

(assert (equals? x '(1 2)))

(assert (equals? '(1 . 2) '( 1 . 2)))
(assert-not (equals? '(1 . 2) '(2 . 1)))
(assert (= 10 (do 1 2 10)))

(println '(:a))

(assert (= 3 (plookup '(:a 1 :b 2 :c 3 :d 4) :c)))
(assert-not (plookup '(:a 1 :b 2 :c 3 :d 4) :g))

(assert (symbol? 'test-sym))
(assert-not (symbol? 1))

(let ((v1 (make-vector 1 (float32 0))))
  (assert (= (vector-ref v1 0) (float32 0)))
  (vector-set! v1 0 (float32 1.0))
  (assert-not (= (float32 1.0) (float32 0.0)))
  (assert (= (float32 1.0) (float32 1.0)))
  (assert (= (vector-ref v1 0) (float32 1.0)))
  )

(let ((l '(3 4 5)))
  (assert (eq (pop! l) 3))
  (assert (eq (pop! l) 4))
  (push! l 6)
  (push! l 7)
  (assert (eq (pop! l) 7))
  (assert (eq (pop! l) 6))
  
  )

(let ((ok nil))
  (match x (plookup '(:a 1 :b 2) ':b)
			(set! ok (eq x 2)))
  (assert ok))
(match x (plookup '(:a 1 :b 2) ':c)
		 (assert nil))

(let ((ht (make-hashtable nil nil)))
  (hashtable-set ht 5 10)
  (assert (eq 10 (hashtable-ref ht 5)))
  (assert-not (hashtable-ref ht 10))
  (hashtable-remove ht 5)
  (assert-not (hashtable-ref ht 5))
  )
(println (string->vector "123"))
(assert (equals? "123" (vector->string (string->vector "123"))))
(assert-not (= "123" (vector->string (string->vector "123"))))
(let ((expect '(1 2 3)))
  (assert (equals? expect (read-string (vector->string (string->vector (value->string expect))))))
  (assert-not (eq expect (read-string (vector->string (string->vector (value->string expect))))))
  )


(println (parse-hex "00cc"))
(println (hex-string 100 6))
(println (hex-string 1000000))
(assert (symbol? :a))
(assert (eq ':a :a))
(assert (eq :a :a))
(assert-not (eq '':a :a))

(println (list ':a :a '':a))

(define teststr "\"1\"" )

(define var1 5)
((lambda ()
  (define var1 6)
  (assert (eq var1 6))))
(assert (eq var1 5))

(let ((teststr "(:emacs-rex (swank:connection-info) ""COMMON-LISP-USER"" t 1)")
      (first :emacs-rex))
  (assert (eq (car (read-string teststr)) :emacs-rex)))

(defun test-cond (x)
  (cond
    ((symbol? x) 1)
    ((integer? x) 2)
    (else 3)))

(assert (eq 1 (test-cond 'a)))
(assert (eq 2 (test-cond 3)))
(assert (eq 3 (test-cond 3.0)))
(assert (eq 3 (cadr (println (memq :b (list :a 2 :b 3 :c 4))))))

(let* ((a 1) (b (+ a 1)) (c (+ b 1)))
  (assert (eq 3 c))
  (assert (eq 2 b))
  (assert (eq 1 a)))

(defun ht-stress ()
  (let ((ht (make-hashtable nil nil)))
    (do-times 20 (lambda (i)
                    (hashtable-set ht (cons i i) i)
                    (vector->string (string->vector (value->string '(1 2 3))))
                    ))))
(do-times 20 (lambda (i) (ht-stress)))

(println (eval '(progn (+ 1 2))))
;(println ("\\\"asd\\\""))
(define asdstr (read-string (read-string "\"asd\"")))
(define hej 10)
(println (symbol-procedure? 'apply))
(println asdstr)
(assert (unbound? 'hejjj))
(assert (bound? 'hej))

(define countup nil)
(define clear nil)

(let ((counter 0) (decrement ()))
  (set! countup (lambda ()
                  (set! counter (+ counter 1))
                  (push! decrement (lambda () (set! counter (- counter 1))))
                  counter
                  
                  ))
  (set! clear (lambda ()
                (map! funcall decrement)
                (set! decrement nil)
                nil
                ))
  )
(do-times 10 countup)
(println (countup))
(clear)
(println (countup))
  


(println "Tests Passed")


  
