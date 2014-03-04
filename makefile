ArrayMaxRun : ArrayMax
	./ArrayMax >ArrayMax-output-temp.txt

ArrayMax : ArrayMax.hs
	ghc --make ArrayMax

my : ArrayMaxNew
	./ArrayMaxNew >ArrayMaxNew-output-temp.txt

ArrayMaxNew : ArrayMaxNew.hs M1run.hs M1cpu.hs
	ghc --make ArrayMaxNew

clean :
	-rm -f *.o *.hi *~ *temp.txt
	-rm -f ArrayMax
	-rm -f ArrayMaxNew
