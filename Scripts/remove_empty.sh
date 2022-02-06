#!/bin/sh
###############################################################################################
###############################################################################################
for i in "$@"
do
    old_name="$i"
    new_name=${old_name%.*}_remove_empty.krn
    for j in `seq 1 7`;
    do
        spine= extract -f $j $i; 
        # removed= $spine rid -GLId;
        # expr= grep '^[^=]' $removed;
        echo $spine
    done
done
