
#	Create a Simple Neural Network in Python from Scratch

I watched the video (by Jonas Bostoen), decided to follow along but in Racket. I'm gonna keep playing with this until I understand what it's doing. 

Racket was challenging but much easier that recoded this perceptron in Haskell.  The biggest benefit of Racket was probably the IDE and the ability to use very symbolic function 
names (matix+ for exp). Racket turned out to be pretty slow, however the docs said that typed version would be 25 to 50 times faster.

Haskell took longer to write and was quite difficult to debug  In the end, its performance was equal to Python's, and that was a  simple list implementation of matrices
with some hand-written matrix functions.  I may try Haskell again later with a real Matrix package.

After a little exposure to  numPy and R, I'm beginning to understand the usage of special packages for this type of research.  Well, next it's on to Common Lisp, R. I considered CERN's ROOT, but decided not to use it unless I had to deal with an extremely large dataset, mostly because users claimed that the was its only claim to fame.

I also want to learn to use those web-based science "notebooks." 

Wed 18 Mar 2020 11:32:34 PM PDT
I coded the perceptron (percy.m) in Octave.  Octave was such a joy (no pun). Everything was built-in and the syntax was natural. No need to add print statements, just leave off the semicolons and expressions automatically print. Alas, Octave was only half as fast as homegrown Haskell (or numPy) implementations of Percy the perceptron. 

Julia was a disappointment, not as simple as Octave when it came to using matrix operations.  Matrix M => Exp^M required writing the function (because square matrices). 1 - M also was a problem. Julia in general made me research and use alternate methods for matrix operations.  It's strict--maybe that's a good thing.  Performance was slow about 5-1/2 times as long to run as Haskell (or numPy), yet still way faster than Racket. 

Fri 20 Mar 2020 01:01:08 PM PDT
JavaScript was interestingly fast(percy.js). It produced results at 1/3 the speed of Python,of GHC, but was nearly twice as fast a Julia. I actually had to hand-code part of the math, even though I used the mathjs package, because it didn't seem to have any off the shelf Hadamard product-like functions. I used the array rather than the matrix types.


| Tool    |      | Secs  | Language     |
|---------|------|-------|-------------|
| numPy   | real | 0.38  | Python      |
| GHC     | real | 0.35  | Haskell     |
| Racket  | real |14.62  | Scheme      |
| Octave  | real | 0.69  | MATLAB      |
| Julia   | real | 2.16  | Julia       |
| Node    | real | 1.22  | JavaScript  |


## References

1. Intro: YouTube video:        https://www.youtube.com/watch?v=kft1AJ9WVDk&t=634s
2. GitHub accompaniment:        https://github.com/jonasbostoen/simple-neural-network
8. Original technical analysis: https://iamtrask.github.io/2015/07/12/basic-python-network/
3. Numeric.LinearAlgebra.Data:  https://hackage.haskell.org/package/hmatrix
4. Rosetta Code                 https://rosettacode.org/wiki/Matrix_multiplication
5. Data.Matrix(matrix):         https://hackage.haskell.org/package/matrix
6. Matrix Multiplication:       https://www.mathsisfun.com/algebra/matrix-multiplying.html
7. Hadamard product:            https://en.wikipedia.org/wiki/Hadamard_product_(matrices)
