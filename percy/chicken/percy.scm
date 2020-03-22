(require-extension linear-algebra)
(define (k-m k m)(map-matrix (lambda(x)(- k x)) m))
(define (k/m k m)(map-matrix (lambda(x)(/ k x)) m))
(define (exp-matrix m)(map-matrix exp m))
(define (recip-matrix m)(k/m 1 m))
  
(use srfi-27)
(define (randoms n)
  (do ( (c 0 (+ c 1))
	(rs '() (cons (random-real) rs))) ((>= c n) rs)))

(define-syntax
  visidef
  (syntax-rules ()
    ((_ name Mx) (begin (define name Mx)
			(display 'name) (display ": ")(print  name)))))
;; -------------------------------------------------------------
(visidef training-inputs #(#(0 0 1)#(1 1 1 )#(1 0 1) #(0 1 1)))
(define input-layer training-inputs)
(visidef training-outputs #(#(0)#(1) #(1) #(0)))

(define (sigmoid x)(map-matrix (lambda(x)(/ 1 x))
			       (k+m 1 (exp-matrix (m*k x -1)))))
(define (sigderiv x)(m* x (k-m 1 x)))
 
(visidef synaptic-weights (list->matrix (map list (randoms 3))))
;;----------------------------------------------------------
(define (outf inp) (sigmoid (m* inp synaptic-weights)))
(define (new-weights adj)
  (m+ synaptic-weights (m* (matrix-transpose input-layer) adj)))

(display "\nOutput:")

(print (do ((i 1(+ i 1))) ((> i 20000) (outf input-layer))
	    (let*((output (outf input-layer))
		  (error (m- training-outputs output))
		  (adjustments (m*. error (sigderiv output)))) 
	      (set! synaptic-weights (new-weights adjustments)))))
;; ----------------------------------------------------------	 
(display "\nWeights after training: ")             (print synaptic-weights)
(display "\nOutput for novel input: [1 0 0 ] => ") (print (outf  #(#(1 0 0 ))))


