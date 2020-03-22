TIME = time -p
TARGETS=
SrcDirs=. percy

include percy/percy.mak

.SUFFIXES: .hs

% : %.hs
	ghc -O3 -ipercy --make $@

% : %.scm
	csc -O3 -local -f -inline -strict-types $<

all:: ${TARGETS}



clean::
	@for d in ${SrcDirs}; do\
	( cd $$d ;\
	 [ -d Attic ] || mkdir -v Attic ;\
	 for x in "#"* *~ *.hi *.o; \
	   do test ! -e $$x || mv -v "$$x" Attic/; done ; \
	) ;\
	done 
	@echo ok.

