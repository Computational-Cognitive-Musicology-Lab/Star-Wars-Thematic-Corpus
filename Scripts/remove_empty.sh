#!/bin/sh
###############################################################################################
###############################################################################################
for i in "$@"
do
    old_name="$i"
    new_name=${old_name%.*}_remove_empty.krn
    array=$(seq 1 7)
    let k=0
    for j in $array;
    do
        # spine= extract -f $j $i;
        let k++;
        removed= extract -f $j $i | ridx -GLIdM;
        # echo "$removed";
        # myVar=`echo $removed | sed 's/ *$//g'`
        # echo $myVar
        python "../../Scripts/remove_empty.py" $k
        # if [ "$myVar" == '' ];
        # then
        #     # echo $k
        #     # echo "is empty"
        #     # assemble new_name spine > new_name;
        # else
        #     # echo "not empty"
        # fi
    done

done
