TIME = time -p
TARGETS=perceptron

.SUFFIXES: .hs

% : %.hs
	ghc --make $@

all: ${TARGETS}

perceptron: Matrix.hs

test:
	${TIME} python percy.py; echo
	ghc --make perceptron; ${TIME} ./perceptron; echo
	${TIME} racket percy.rkt; echo
	${TIME} octave percy.m; echo

clean:
	@[ -d Attic ] || mkdir -v Attic
	@for x in  *~ *.hi *.o; \
	    do test "$${x:0:1}" = '*' || mv -v "$$x" Attic/; done
	@echo ok.

