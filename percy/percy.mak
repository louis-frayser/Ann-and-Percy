#-*-makefile-*-
PTARGETS=percy/percy
TARGETS+=${PTARGETS}

percy/percy: percy/Matrix.hs

run test runtests:: ${PTARGETS}
	 { echo "numPy:";\
	  ${TIME} python percy/percy.py; echo ;\
	  echo "GHC:" ;\
	  ${TIME} percy/percy; echo;\
	  echo "Racket:" ;\
	  ${TIME} racket percy/percy.rkt; echo ;\
	  echo "Octave:" ;\
	  ${TIME} octave percy/percy.m; echo ;\
	  echo "Julia:" ;\
	  ${TIME} julia percy/percy.jl; echo ;\
	  echo "Node.js:" ;\
	  ${TIME} node percy/percy.js; echo  ;\
        } 2>&1 |tee times.log

report:: times.log
	egrep  '(numPy|GHC|Racket|Octave|Julia|Node.js):|real' times.log |while read app; do read _real time; printf "%-11s %5.2f\n" "$$app" "$$time";done
