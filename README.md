
%	Create a Simple Neural Network in Python from Scratch

I watched the video (by Jonas Bostoen), decided to follow along but in Racket. I'm gonna keep playing
with this until I understand what it's doing. 

Racket was challenging but much easier that recoded this perceptron in Haskell.  The biggest benefit
of Racket was probably the IDE and the ability to use very symbolic function 
names (matix+ for exp). Racket turned out to be pretty slow, however the docs
said that typed version would be 25 to 50 times faster.

Haskell took longer to write and was quite difficult to debug  In the end, its
performance was equal to Python's, and that was a  simple list implementation of matrices
with some hand-written matrix functions.  I may try Haskell again later with a 
real Matrix package.

After a little exposure numPy and R, I'm beginning to understand the usage of special packages
for this type of research.  Well, next it's one to Common Lisp, R and  maybe Julia.
I want to learn about using these web-based science "notebooks." 

Wed 18 Mar 2020 11:32:34 PM PDT
I coded the perceptron (percy) in Octave.  Octave was such a joy (no pun). Everything was built-in and the syntax was natural. No need to add print statements, just leave off the simicolons and expressins automatically print.

Julia was disapointint. Not as simple as Octave when it came to using matrix operations.  Matrix M => Exp^M required writing the function (because square matrices). 1 - M also was a problem It 
in general made me research and use alternate method for matrix operations.  It's strict--maybe that' a good thing.  Performace was slow about 5-1/2 times as long to run as Haskell, Python (still way faster than Racket.) 


# References #

1. YouTube video:              https://www.youtube.com/watch?v=kft1AJ9WVDk&t=634s
2. GitHub original:            https://github.com/jonasbostoen/simple-neural-network
3. Numeric.LinearAlgebra.Data: https://hackage.haskell.org/package/hmatrix
4. Rosetta Code                https://rosettacode.org/wiki/Matrix_multiplication
5. Data.Matrix(matrix):        https://hackage.haskell.org/package/matrix
6. Matrix Multiplication:      https://www.mathsisfun.com/algebra/matrix-multiplying.html
7. Hadamard product:           https://en.wikipedia.org/wiki/Hadamard_product_(matrices)
8. Technical discussion:       https://iamtrask.github.io/2015/07/12/basic-python-network/
