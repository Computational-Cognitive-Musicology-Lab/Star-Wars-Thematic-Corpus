#!/bin/sh


for i in "$@"
do
old_name="$i"
title=${old_name%.*}
space_title=${$title/'_Basic_renamed'/''}
space_title=${$space_title//'_'/' '}
space_title=${$space_title/'^[0-9]*'/''}
# sed -E -e 's/_Basic_renamed//g' \
# -Ee 's/_/ /g' \
# -Ee 's/^\d* //g' $title
echo $space_title
# sed -i '1s/^/\!\!\!COM: John Williams\n/' $i
done
exit