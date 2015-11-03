#!/bin/bash

site=.com
mkdir output
tempfile=output/temp.log
results=`date "+%Y%m%d-%H%M%S"`-results.txt
#dorklist=dorks/dorks.txt
dorklist=dorks/dorks.min


if [ -z "$1" ]
then
        echo "No argument 1 supplied (courtry or dork site:)"
else
        # TODO - do not run as root
                site=$1
fi



./dork-and-diff.sh $tempfile $site $dorklist


# remove duplicates from file
#awk '!seen[$0]++' $tempfile > output/$results

# --------------- Making results file from temp file ----------------------------------
LINKS=`cat $tempfile | egrep -o "http[^\"]+"`
DOMAINS=`echo "$LINKS" | cut -d / -f 3 | cut -d : -f 1 | grep -v "^$"`
#echo $LINKS
echo "" > output/$results
echo "-----------------------" >> output/$results
echo "-------- DOMAINS ------" >> output/$results
echo "-----------------------" >> output/$results
#echo $DOMAINS
echo "$DOMAINS" | grep -v "^$" |uniq | sort >> output/$results

echo "" >> output/$results

echo "-----------------------" >> output/$results
echo "-------- RESULTS ------" >> output/$results
echo "-----------------------" >> output/$results
cat $tempfile >> output/$results

rm -f $tempfile
cat output/$results;


echo " -----------------  Make archive and diff -----------------"
# if do not exist, create old and latest
#mkdir archive
#mkdir latest
#mkdir diffed

mkdir -p output/archive
mkdir -p output/latest
mkdir -p output/diffed

echo " -----------------  DIFF WITH LATEST -----------------"
mv output/diffed/*.* output/archive/
diff output/$results output/latest/*.txt > output/diffed/$results-diff-with-latest.txt
mv output/latest/*.txt output/archive/
mv output/$results output/latest/

cat output/diffed/$results-diff-with-latest.txt


echo "------- SENDING MAIL ----------"
echo "ssmtp should be configured"
#mailtothem=root@localhost

#echo -e "to: $mailtothem\nSubject: [Dork][$site] - \n" | (cat - && cat ./output/latest/$results && uuencode ./output/latest/$results ./output/latest/$results && uuencode ./output/diffed/$results-diff-with-latest.txt ./output/diffed/$results-diff-with-latest.txt)  | /usr/sbin/ssmtp $mailtothem


