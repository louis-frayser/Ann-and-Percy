TIME = time -p
TARGETS=
PASUB=percy+ann
SrcDirs=. ${PASUB}

include ${PASUB}/p+a.mak

.SUFFIXES: .hs

% : %.hs
	ghc -O3 -i${PASUB} --make $@

% : %.scm
	csc -O3 -local  -inline -strict-types $<

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

