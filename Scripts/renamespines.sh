#!/bin/sh


for i in "$@"
do

old_name="$i"
new_name=${old_name%.*}_renamed.krn
    sed 's/**text/**harm/' $old_name | sed 's/**text/**altharm/' | sed 's/**text/**pedal/' | sed 's/**text/**cadence/' > renamed.txt
    extract -i "**kern,**harte" renamed.txt > renamed1.txt
    extract -i "**harm,**altharm,**pedal,**cadence,**text" renamed.txt > renamed2.txt
    assemble renamed1.txt renamed2.txt > merged.txt

    value=$(<merged.txt)
    pat='\!LO:TX:t=\[([-a-z]*)\]=([0-9]*)'

    [[ $value =~ $pat ]]
    beat="${BASH_REMATCH[1]}"
    if [ "$beat" = 'quarter' ]
    then
        tempo=${BASH_REMATCH[2]}
    elif [ "$beat" = 'half' ];
    then
        tempo=$((${BASH_REMATCH[2]} * 2))
    elif [[ "$beat" = 'quarter-dot' ]];
    then
        tempo=$((${BASH_REMATCH[2]} * 3 / 2))
    elif [[ "$beat" = 'eighth' ]];
    then
        tempo=$((${BASH_REMATCH[2]} / 2))
    fi
    # else
        # echo "no match"
    # fi;
    # echo $old_name
    # echo $beat
    # echo ${BASH_REMATCH[2]}
    # echo $tempo

    
    sed -E -e 's/b([VIvi]+.*)/-\1/g' \
	-Ee 's:[^M]([65432])/([5432]):\1\2:g' \
	-Ee 's/b([23679])/m\1/g' \
	-Ee 's/b13/m13/g' \
	-Ee 's/b11/D11/g' \
	-Ee 's/b([45])/D\1/g' \
	-Ee 's/#([1-9]+)/A\1/g' \
	-Ee 's/#([1-9]+)/A\1/g' \
	-Ee 's:%7:om7:g' \
	-Ee 's/([VIvi]+)o7/\1oD7/g' \
	-Ee 's/([VIvi]+[/o+m]*)65/\17b/g' \
	-Ee 's/([VIvi]+[/o+m]*)43/\17c/g' \
	-Ee 's/([VIvi]+[/o+m]*)42/\17d/g' \
	-Ee 's/([VIvi]+[/o+m]*)2/\17d/g' \
	-Ee 's/([VIvi]+[/o+m]*)64/\1c/g' \
	-Ee 's/([VIvi]+[/o+m]*)6/\1b/g' \
	-Ee 's/([VIvi]+)o7/\1oD7/g' \
	-Ee 's:/o:om:g' \
	-Ee 's/Ger[34567]*/Gn/g' \
	-Ee 's/It[34567]*/Lt/g' \
	-Ee 's/#viio/viio/g' \
	-Ee 's/@none/NC/g' \
	-Ee 's:\\:}:g' \
	-Ee 's/^(\*k\[([a-g][-#])*\])\t\*\t\*/\1\t\1\t\1/g' \
	-Ee 's/^(\*[a-gA-G][-#]?:)\t\*\t\*/\1\t\1\t\1/g' \
	-Ee 's:^(\*M[0-9]+\/?[0-9]*)\t\*\t\*:\1\t\1\t\1:g' \
    -Ee "s/\!LO:TX:t=\[([-a-z ]*)\]=([0-9]*)/*MM$tempo/g" merged.txt | rid -GL | sed -Ee "s/\!/\*/g" > $new_name 
    
    rm -r renamed.txt
    rm -r renamed1.txt
    rm -r renamed2.txt
    rm -r merged.txt

    # add header information
    header="!!!COM: John Williams\n!!!ENC: Frank Lehman\n!!!EED: Claire Arthur\n!!!EED2: John McNamara\n"
    
    echo $header | cat - $new_name > temp && mv temp $new_name


done
exit