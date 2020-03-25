#lang racket
;-*-Scheme-*-
(require math/matrix)

(define (sigmoid x)(/ 1.0 (+ 1 (exp (- x)))))
(define (sigmo-deriv x) (* x (- 1 x)))

;; Hadamard product in and out are 4x1 mat
(define (hadamard* a b)(matrix-map * a b))
  
(define %training-inputs (matrix [[0 0 1] ; example 1
                                  [1 1 1] ; exapmle 2
                                  [1 0 1] ; ...
                                  [0 1 1]]))
(define %training-outputs (matrix-transpose (matrix [[0 1 1 0]])))

#|(random-seed 1) ;; Seed current/default rgen|#
(define %synaptic-weights
  (list->matrix 3 1 (map (lambda (r) (- (* 2 r)  1)) (list (random) (random) (random)))))

(define-syntax-rule(note annot mat)
  (begin (newline)(displayln annot)(writeln mat)))
(note "Training inputs:"  %training-inputs )
(note "Training outputs:" %training-outputs)
(note "Random starting synaptic weights:" %synaptic-weights)

(define Output #f) (define Input-layer #f)
(set! Input-layer %training-inputs)

(do ( (it 1 (+ 1 it) ) )
  ((>=  it 20000) ) 
  (set! Output (matrix-map sigmoid (matrix* Input-layer %synaptic-weights)))
  (let* ((error (matrix- %training-outputs Output))
         (deriv (matrix-map sigmo-deriv Output))
         (adj (hadamard* error deriv)))
    (set! %synaptic-weights
          (matrix+ %synaptic-weights
                   (matrix* (matrix-transpose Input-layer) adj)))))

(note"Synaptic weights after training:" %synaptic-weights)
(note "Outputs after training:"  Output)
 
(note "Output for novel input: [1 0 0 ] => "
      (matrix-map sigmoid (matrix* (matrix [[ 1 0 0]]) %synaptic-weights)))
