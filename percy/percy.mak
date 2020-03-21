#-*-makefile-*-
TARGETS+=percy/perceptron


percy/perceptron: percy/Matrix.hs

test::
	{ \
	  ${TIME} python percy/percy.py; echo ;\
	  ghc --make percy/perceptron; ${TIME} percy/perceptron; echo;\
	  ${TIME} racket percy/percy.rkt; echo ;\
	  ${TIME} octave percy/percy.m; echo ;\
	  ${TIME} julia percy/percy.jl; echo ;\
	  ${TIME} node percy/percy.js; echo  ;\
        } 2>&1 |tee times.log
