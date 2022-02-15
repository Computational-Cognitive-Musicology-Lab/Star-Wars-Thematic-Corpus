#!/bin/sh
###############################################################################################
###############################################################################################
for i in "$@"
do
    old_name="$i"
    new_name=${old_name%.*}_remove_empty.krn
    array=$(seq 1 7)
    fstring=""

    for j in $array;
    do
        removed=$(extract -f $j $i | ridx -GLIdM);

	if [ -z "$removed" ]
        then
            array=( "${array[@]/$j}" ) 
        else
            fstring="$fstring,$j"
        fi
    done

    fstring="${fstring:1}"
    extract -f ${fstring} ${i} > $new_name

done
