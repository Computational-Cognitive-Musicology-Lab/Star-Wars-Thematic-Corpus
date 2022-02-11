#!/bin/sh
###############################################################################################
###############################################################################################
for i in "$@"
do
    old_name="$i"
    new_name=${old_name%.*}_remove_empty.krn
    array=$(seq 1 7)
    k=0
    for j in $array;
    do
        spine= extract -f $j $i;
        removed= extract -f $j $i | ridx -GLIdM;
        echo "$removed"
        echo "________"
    #     # if [ -z "$removed" ]
    #     # then
    #     #     echo "print"
    #     #     # echo $removed;
    #     #     # assemble new_name spine > new_name;
    #     # fi
    done
    # # echo "$removed"
done
