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
	egrep -v "Algebra|Compiling|Float|Type|$<" $< >>$@
	echo >> $@
	egrep -v reading: ${pfTlog} |tee -a $@

.ONESHELL:
${pfLog} : ${pfSrc} ${pfHOME}/*.mak
	@INPUT=${pfHOME}/percy.input
	echo ")set output algebra ${pfLog}" > $$INPUT
	echo ")set output algebra on" >> $$INPUT
	cat $< >> $$INPUT
	echo -e ")set output algebra console\r)q" >> $$INPUT
	${TIME} fricas ${FRCSFLAGS} \
		-eval ")read $$INPUT" 2> ${pfTlog} >/dev/null
