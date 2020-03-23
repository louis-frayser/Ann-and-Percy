#-*-make-*-
#### Percy in Frickas (Axiom)
pfHOME=${PWD}/percy/fricas
SrcDirs+=${pfHOME}
pfReport=${pfHOME}/fricas.rpt
PREPORTS+=${pfReport}
pfLog=${pfHOME}/fricas.log
pfSrc=${pfHOME}/percy.spad
pfTlog=${pfHOME}/fricas.tmp
FRCSFLAGS=-nox
pf : ${pfReport}
	less $<

runtests test run:: ${pfReport}

${pfReport}: ${pfLog}
	echo Fricas: >$@
	egrep -v "Algebra|Float|X11|Type|$<" $< >>$@
	echo >> $@
	egrep -v Doc ${pfTlog} |tee -a $@


${pfLog} : ${pfSrc} ${pfHOME}/*.mak
	@INPUT=${pfHOME}/.axiom.input ;\
	echo ")set output algebra ${pfLog}" > $$INPUT ;\
	echo ")set output algebra on" >> $$INPUT ;\
	cat $< >> $$INPUT ;\
	echo -e ")set output algebra console\n)quit" >> $$INPUT ;\
	HOME=${pfHOME} ${TIME} fricas ${FRCFLAGS}  >& ${pfTlog}
