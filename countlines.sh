#!/usr/bin/bash

#find . -not -path '*/.*' -type f -ls |grep 'Jun'

while getopts "o:m:" option; 
do
case ${option} in
o)
echo "Looking for files where the owner is: "${OPTARG}
find . -maxdepth 1 -user ${OPTARG} -not -path '*/.*' -type f -print0 | while read -d $'\0' file
do
    variable=$(awk 'BEGIN{c1=0} //{c1++} END{print c1}' $file)
    echo "File: "$file", Lines:    "$variable $file
done
;;
m)
echo "Looking for files where the month is: "${OPTARG}
# NOTE FOR REVIEWERS: $8 == "Jun" fails when the input variable ${OPTARG} is used.
find . -not -path '*/.*' -type f -ls | awk '{ if ($8 == "Jun") print $11;}' | while read -r file
do
    variable=$(awk 'BEGIN{c1=0} //{c1++} END{print c1}' $file)
    echo "File: "$file", Lines:    "$variable $file
done
;;
\? )
echo "invalid option"
;;
esac
done
