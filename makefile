ArrayMaxRun : ArrayMax
	./ArrayMax >ArrayMax-output-temp.txt

ArrayMax : ArrayMax.hs
	ghc --make ArrayMax

clean :
	rm -f *.o *.hi *~ *temp.txt
	rm -f ArrayMax
