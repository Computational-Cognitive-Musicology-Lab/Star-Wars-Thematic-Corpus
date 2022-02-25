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
new_name=${old_name%.*}_harm.txt
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
	-Ee 's:^(\*M[0-9]+\/?[0-9]*)\t\*\t\*:\1\t\1\t\1:g' ${i} > $new_name 
done

exit
