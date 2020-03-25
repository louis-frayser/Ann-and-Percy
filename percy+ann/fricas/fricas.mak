#-*-make-*-
#### Percy in Frickas (Axiom)
pfHOME=${PASUB}/fricas
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
	rm ${pfTlog}

.ONESHELL:
define run-fricas = 
  @set -e; src=$(firstword $^) 
  input=$${src%.spad}.input
  echo ")set output algebra ${pfLog}" > $$input
  echo ")set output algebra on" >> $$input
  cat $< >> $$input
  echo -e ")set output algebra console\n)q" >> $$input
  ${TIME} fricas ${FRCSFLAGS} \
     -eval ")read $$input" 2> ${pfTlog} >/dev/null
endef

${pfLog} : ${pfSrc} ${pfHOME}/fricas.mak
	 $(run-fricas)

