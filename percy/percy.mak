#-*-makefile-*-
PTARGETS=percy/percy percy/chicken/percy
SrcDirs+=percy/chicken

run test runtests:: ${PTARGETS}
	 { echo "numPy:";\
	  ${TIME} python percy/percy.py; echo ;\
	  echo "GHC:" ;\
	  ${TIME} percy/percy; echo;\
	  echo "Racket:" ;\
	  ${TIME} racket percy/percy.rkt; echo ;\
	  echo "Typed Racket:" ;\
	  ${TIME} racket percy/percy-typed.rkt; echo ;\
	  echo "Octave:" ;\
	  ${TIME} octave percy/percy.m; echo ;\
	  echo "Julia:" ;\
	  ${TIME} julia percy/percy.jl; echo ;\
	  echo "Node.js:" ;\
	  ${TIME} node percy/percy.js; echo  ;\
	  echo "CSC Chicken:"; echo ;\
	  ${TIME} percy/chicken/percy; echo  ;\
	  echo "CSI Chicken:"; echo ;\
	  ${TIME} csi -s percy/chicken/percy.scm; echo  ;\
        } 2>&1 |tee times.log

report:: times.log
	@egrep  '(numPy|GHC|Racket|Octave|Julia|Node.js|Chicken):|real' times.log |while read app; do read _real time; printf "| %-14s | %5.2f |\n" "$${app%:}" "$$time";done |sort -t'|' -k3n

percy/percy : percy/Matrix.hs
percy/chicken/chicken : percy/chicken/percy.scm
