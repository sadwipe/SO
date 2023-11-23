#!/bin/bash

echo "Te rog introdu numele directorului"
read dir

#verificam daca variabila este goala
if test -z "$dir"
	then
	echo "Nu ai introdus nimic! Nu ai treaba acasa?!"
	exit
fi

#verificam daca fisierul este valid
if ! test -d "$dir"
	then
	echo "Directorul nu este valid" 
	exit
fi

#salvam numarul fisierelor obisnuite in variabila nrFis
nrFis=$(ls -l "$dir" | grep ^- | wc -l)

#daca fisierul nu contine fisiere, exit
if test $nrFis -eq 0
	then
	echo "Directorul specificat nu are fisier."
	exit
fi


max=0
#fisierul max
maxFile=""
#parcurge fisierle din director
for i in "$dir"/* ; do
	#daca gaseste director sare peste el
	if test -d "$i"
		then
		continue
	fi
	
	#dim = dimensiunea fisierului este stocata in dim
	dim=$(stat -c %s "$i")
	
	if test $dim -gt $max
		then
		max=$dim
		maxFile="$i"
	fi
done

echo "Cel mai mare fisier din $dir este $(basename $maxFile) avand dimensiunea de $max"

#ls -l | grep ^-  // pentru a afisa doar fisierele din terminal
#ls -l | grep ^- | wc -l // pentru a numara cate fisiere sunt 