#lang typed/racket
;;-*-Scheme-*-
(require math/matrix)

(define-type Flomat (Matrix Flonum))
(define-type Flow (-> Flonum Flonum))

(: sigmoid Flow) 
(define (sigmoid x)(/ 1.0 (+ 1 (exp (- x)))))
(: sigmo-deriv Flow)
(define (sigmo-deriv x) (* x (- 1 x)))

;; Hadamard product in and out are 4x1 mat
(: hadamard* (-> Flomat Flomat Flomat))
(define (hadamard* a b)(matrix-map * a b))
 
(define %training-inputs (matrix [[0.0 0.0 1.0] ; example 1
                                  [1.0 1.0 1.0] ; exapmle 2
                                  [1.0 0.0 1.0] ; ...
                                  [0.0 1.0 1.0]] : Flonum) )
(define %training-outputs (matrix-transpose (matrix [[0 1 1 0]])))

#|(random-seed 1) ;; Seed current/default rgen|#
(: rnorm  Flow)
(define (rnorm r ) (- (* 2 r )  1.0) )
(: %synaptic-weights Flomat)
(define %synaptic-weights
  (list->matrix 3 1 (map rnorm (list (random) (random) (random ) ) )))

(define-syntax-rule(note annot mat)
  (begin (newline)(displayln annot)(writeln mat)))
(note "Training inputs:"  %training-inputs )
(note "Training outputs:" %training-outputs)
(note "Random starting synaptic weights:" %synaptic-weights)


(define Input-layer %training-inputs)
(define (outfun) (matrix-map sigmoid (matrix* Input-layer %synaptic-weights)))

(: train (-> Flomat))
(define (train)
  (do ( (i 1 (+ i 1)) (output : Flomat (outfun) (outfun)))
    ((>= i 20000) output)
    (let* ((err  (matrix- %training-outputs output))
           (deriv (matrix-map sigmo-deriv output))
           (adj   (hadamard* err deriv)) )
      (set! %synaptic-weights
            (matrix+ %synaptic-weights
                     (matrix* (matrix-transpose Input-layer) adj))))))

(note"Synaptic weights after training:" %synaptic-weights)
(note "Outputs after training:"  (train))
 
(note "Output for novel input: [1 0 0 ] => "
      (matrix-map sigmoid (matrix* (matrix [[ 1.0 0.0 0.0 ]]) %synaptic-weights)))
