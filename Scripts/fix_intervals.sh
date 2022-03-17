#!/bin/sh

for i in "$@"
do
old_name="$i"
new_name=${old_name%.*}_fixedFlat.krn
sed -E -e 's/([ABCDEFG])b/\1-/g' ${i} > $new_name
done

exit


for i in "$@"
do

old_name="$i"
new_name=${old_name%.*}_fixedInterval.krn

    
    sed -E -e 's/m2/b2/g' \
    -Ee 's/([^*M])M2/\12/g' \
    -Ee 's/A2/#2/g'
    -Ee 's/(^[^?])*m3([^?]*$)/\1b3\2/g' \
	-Ee 's/(^[^?])*M3([^?]*$)/\13\2/g' ${i} > $new_name  
    # -Ee 's/A4/#4/g' \
    # -Ee 's/D5/b5/g' \
    # -Ee 's/D6/bb6/g' \
    # -Ee 's/m6/b6/g' \
    # -Ee 's/M6/6/g' \
    # -Ee 's/A6/#6/g' \
    # -Ee 's/D7/bb7/g' \
    # -Ee 's/m7/b7/g' \
    # -Ee 's/M7/7/g' \
    # -Ee 's/m9/b9/g' \ 
    # -Ee 's/M9/9/g' ${i} > $new_name 
    

done
exit