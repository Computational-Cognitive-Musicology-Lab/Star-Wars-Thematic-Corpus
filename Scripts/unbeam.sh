#!/bin/sh
###############################################################################################
# Test for converting RNtxt to **harm
# Note: Using Frank Lehman's analyses encoded in RNtxt as sample material.

# Parser test1

# NOTES
# inversions convert from numeric to alphabet;
# augmented and diminished triads are already the same;
# for some reason M is a designation for M7 but not m for m7??
# flat intervals are converted to minor if they are dissonant or imperfect; dim if they are perfect;
# RNtxt allows inversions to be written with OR without slash so keep this line for caution (it doesn't hurt)
# because of om7 and oD7 for all inversions all types of dim7 must be dealt with twice;
# \\ only indicates phrase ends and not beginnings, so translation technically makes incorrect humdrum.
# #viio is considered courtesy accidental so translating could have problems
# humdrum does not have symbol for "no chord". We adopt "NC" since "Nc" would mean Neapolitan in 2nd inv.
# Rntxt indicates a beat with nothing following the beat (so two beats in a row) to indicate NC/@none
# xxx this currently uses sed not humsed so it will translate ALL text (note Ger and It below);
# NOTE: NOT FIXED FOR DOUBLE FLATS

###############################################################################################
for i in "$@"
do
old_name="$i"
new_name=${old_name%.*}_unbeamed.krn
sed -E -e 's/[KLJk]+\]?\t/\t/g' ${i} > $new_name 
done

exit
