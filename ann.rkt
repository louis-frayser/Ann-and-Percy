#lang racket
;;-*-Scheme-*-
#| https://www.youtube.com/watch?v=kft1AJ9WVDk&t=634s
https://github.com/jonasbostoen/simple-neural-network
|#
(require math/array)

(require math/matrix)
(define (sigmoid x) (/ 1.0 (+ 1 (exp (- x)))))

(define (sigmo-deriv x) (* x (- 1 x)))

;; Hadamard product in and out are 4x1 mat
(define (hadamard* a b)
  (matrix-map * a b))
  
(define %training-inputs (array #[#[0 0 1] ; example 1
                                  #[1 1 1] ; exapmle 2
                                  #[1 0 1] ; ...
                                  #[0 1 1]]))

(define %training-outputs (matrix-transpose (matrix ([0 1 1 0]))))

(random-seed 1) ;; Seed current/default rgen

(define %synaptic-weights
  (list->matrix 3 1
                (map (lambda (r) (- (* 2 r)  1))
                     (list (random) (random) (random)))))

(displayln "Random starting synaptic weights:")
(displayln %synaptic-weights)

(define Output #f)
(define Input-layer #f)
(time 
 (do ( (it 0 (+ 1 it)) )
   ((>=  it 20000) ) 
   (set! Input-layer %training-inputs)
   (set! Output (matrix-map sigmoid (matrix* Input-layer %synaptic-weights)))
   (let* ((error (matrix- %training-outputs Output))
          (deriv (matrix-map sigmo-deriv Output))
          (adj (hadamard* error deriv)))
     (set! %synaptic-weights
           (matrix+ %synaptic-weights
                    (matrix* (matrix-transpose Input-layer)
                             adj)))))

 (displayln "\nSynaptic weights after training:")
 (displayln %synaptic-weights)

 (displayln "\nOutputs after training:")
 (displayln Output)
 )
