#!/bin/sh


for i in "$@"
do

old_name="$i"
sed -E -e "s:rn2harm_renamed_unbracketed_remove_empty::g" $old_name
echo "$old_name"
# echo "$new_name"

    # add header information
    # header="!!!COM: John Williams\n!!!ENC: Frank Lehman\n!!!EED: Claire Arthur\n!!!EED2: John McNamara\n"
    
    # echo $header | cat - $new_name > temp && mv temp $new_name


done
exit