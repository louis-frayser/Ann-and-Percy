#-*-makefile-*-
PTARGETS=percy+ann/percy percy+ann/chicken/percy 
SrcDirs+=percy+ann/chicken
PREPORTS=times.log
all:: ${PTARGETS}

include percy+ann/fricas/fricas.mak


run test runtests:: ${PTARGETS}
	 { echo "numPy:";\
	  ${TIME} python percy+ann/percy.py; echo ;\
	  echo "GHC:" ;\
	  ${TIME} percy+ann/percy; echo;\
	  echo "Racket:" ;\
	  ${TIME} racket percy+ann/percy.rkt; echo ;\
	  echo "Typed Racket:" ;\
	  ${TIME} racket percy+ann/percy-typed.rkt; echo ;\
	  echo "Octave:" ;\
	  ${TIME} octave percy+ann/percy.m; echo ;\
	  echo "Julia:" ;\
	  ${TIME} julia percy+ann/percy.jl; echo ;\
	  echo "Node.js:" ;\
	  ${TIME} node percy+ann/percy.js; echo  ;\
	  echo "CSC Chicken:"; echo ;\
	  ${TIME} percy+ann/chicken/percy; echo  ;\
	  echo "CSI Chicken:"; echo ;\
	  ${TIME} csi -s percy+ann/chicken/percy.scm; echo  ;\
        } 2>&1 |tee times.log

report:: ${PREPORTS}

	@egrep  '(numPy|GHC|Racket|Octave|Julia|Node.js|Chicken|Fricas):|real' ${PREPORTS} |while read app0; do read _real time; app=$${app0#*:}; printf "| %-12s | %5.2f |\n" "$${app%:}" "$$time";done |sort -t'|' -k3n

percy+ann/percy : percy+ann/Matrix.hs
percy+ann/chicken/chicken : percy+ann/chicken/percy.scm

