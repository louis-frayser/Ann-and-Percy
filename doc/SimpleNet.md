
#	A Small Backpropagation Neural Network

I watched a video (by Jonas Bostoen) and decided to follow along, but in Racket instead of Python. I resolved to keep playing with this perceptron algorithm until I understood what it did. Here I present benchmarks for various implementations of the ANN. [See this RStudio article for more indepth analysis.](https://htmlpreview.github.io/?https://github.com/louis-frayser/Ann-and-Percy/blob/master/percy+ann/R/P+A.nb.html)

## Tooling
After a little exposure to numPy, R, and  octave I'm beginning to understand the usage of special languages and packages for this type of research.  Well, next it's on to Common Lisp,another Scheme, and maybe R. I considered CERN's ROOT which I've played with in the past, but decided not to use it unless I need to deal with an extremely large dataset, mostly because users reported that scalability was ROOT's only claim to fame.

I am also learning to use those web-based "science notebooks." I've done some study with RStudio. Sage Math also looks interesting.

### Racket
Translating the 1-layer perceptron code to Racket (Scheme) was challenging but much easier than was translating it to Haskell.  The biggest benefit of Racket was probably the IDE and the ability to use very symbolic function names (matix+ for example). Racket turned out to be pretty slow, however the docs said that Racket's typed version should be 25 to 50 times faster.

#### Typed Racket
Sat 21 Mar 2020 08:12:16 AM PDT
Annotating racket for types was quit difficult. It was a lot like fighting the Haskell type system, maybe a little more frustrating.  I resorted to extracting parts of the code into simpler chunks that I was able to type. Typing produce about a five-fold increase in performance.

### GHC
Haskell took longer to write and was quite difficult to debug  In the end, its performance was equal to Python's, even though I used a simple list-based implementation of matrices with some hand-written matrix functions.  I may try Haskell again later with a real Matrix package.

### Octave
Wed 18 Mar 2020 11:32:34 PM PDT
I coded the perceptron (percy.m) in Octave a MATLAB clone.  Octave was such a joy (no pun). Everything was builtin and the syntax was natural. No need to add print statements, just leave off the semicolons and expressions automatically print. Alas, Octave was only half as fast as the homegrown Haskell (or numPy) implementations of Percy the perceptron.

### Julia
Julia was a disappointment, not as simple as Octave when it came to using matrix operations.  Matrix M => Exp^M required writing the function (because square matrices). 1 - M also was a problem. Julia in general made me research and use alternate methods for matrix operations.  It's strict--maybe that's a good thing.  Performance was slow about 5-1/2 times as long to run as Haskell (or numPy), yet still way faster than untyped Racket.

### JavaScript
Fri 20 Mar 2020 01:01:08 PM PDT
Node.js was interestingly fast(percy.js). It produced results at 1/3 the speed of Python,or GHC, but was nearly twice as fast a Julia. I actually had to hand-code part of the math, even though I used the mathjs package, because it didn't seem to have any off the shelf Hadamard product-like functions. I used the array rather than the Node.js matrix types.

### Chicken Scheme
Sun 22 Mar 2020
Very interesting! Good distributed packaging system. It's pretty fast for this application.

### Fricas (Axiom)
Sun 22 Mar 202
I've learned a lot about Fricas and coded the perceptron in it. I'm appreciating it more as I work with it.  It's not very fast but it has a compiler that may speed things up a bit. Below are are interpreter stats. Fricas is more of a CAS than it is a numerical analysis package.


## Benchmarks
Fri 20 Mar
I did quite a bit of cleanup and tried to ensure the various single-layer perceptron implementations were doing the same work. Most noticeable was the Julia's performance was 20% time spent in I/O.  Writing results really slows it down.  I adjust each package so that they had similar output. Below are updated run-times.

### Sun 22 Mar 2020
Benchmarks updated for Chicken scheme.


| Tool           | Secs  | Language        |
|----------------|-------|-----------------|
| GHC            |  0.21 | Haskell         |
| numPy          |  0.27 | Python          |
| R              |  0.31 | R               |
| CSC Chicken    |  0.41 | Compiled Scheme |
| Octave         |  0.54 | MATLAB          |
| Node.js        |  0.68 | JavaScript      |
| CSI Chicken    |  0.77 | Scheme          |
| Julia          |  1.55 | Julia           |
| Typed Racket   |  2.36 | Typed Scheme    |
| Racket         | 10.12 | Scheme          |
| Fricas         | 10.68 | Fricas/Axiom    |


## References

1. Intro: YouTube video:        https://www.youtube.com/watch?v=kft1AJ9WVDk&t=634s
2. GitHub accompaniment:        https://github.com/jonasbostoen/simple-neural-network
8. Original technical analysis: https://iamtrask.github.io/2015/07/12/basic-python-network/
3. Numeric.LinearAlgebra.Data:  https://hackage.haskell.org/package/hmatrix
4. Rosetta Code                 https://rosettacode.org/wiki/Matrix_multiplication
5. Data.Matrix(matrix):         https://hackage.haskell.org/package/matrix
6. Matrix Multiplication:       https://www.mathsisfun.com/algebra/matrix-multiplying.html
7. Hadamard product:            https://en.wikipedia.org/wiki/Hadamard_product_(matrices)
