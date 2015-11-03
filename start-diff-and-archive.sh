#!/bin/bash



############## TODO 

exit




site=.com
mkdir output
currentdate=`date "+%Y%m%d-%H%M%S"`
tempfile=output/${currentdate}_temp.log
results=output/${currentdate}_results.txt


if [ -z "$1" ]
then
        echo "No argument 1 supplied (temp-filename with csv ext)"
else
                tempfile=$1
fi

if [ -z "$2" ]
then
        echo "No argument 2 supplied (results-filename)"
else
                results=$2
fi



while IFS='' read -r line || [[ -n "$line" ]]; do
	echo "$currentdate|$line" >> "output/$results"
done < "$tempfile.csv"	






echo " -----------------  Make archive and diff -----------------"
# if do not exist, create old and latest
mkdir archive
mkdir latest
mkdir diffed

mkdir -p output/archive
mkdir -p output/latest
mkdir -p output/diffed

echo " -----------------  DIFF WITH LATEST -----------------"
mv output/diffed/*.* output/archive/
diff output/$tempfile output/latest/*.txt > output/diffed/$tempfile-diff-with-latest.txt
mv output/latest/*.txt output/archive/
mv output/$tempfile.csv output/latest/

cat output/diffed/$tempfile-diff-with-latest.txt

echo "------- SENDING MAIL ----------"
echo "ssmtp should be configured"
#mailtothem=root@localhost

#echo -e "to: $mailtothem\nSubject: [Dork][$site] - \n" | (cat - && cat ./output/latest/$results && uuencode ./output/latest/$results ./output/latest/$results && uuencode ./output/diffed/$results-diff-with-latest.txt ./output/diffed/$results-diff-with-latest.txt)  | /usr/sbin/ssmtp $mailtothem


