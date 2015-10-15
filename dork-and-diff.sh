#!/bin/bash

site=.com
filename=dorks.txt
results=`date "+%Y%m%d-%H%M%S"`-results.txt
echo $results
i=0
tempfile=temp.log
WAIT=5

while read -r line
do
        dork="site:$site $line"
	echo " " >> $tempfile
	
	echo "[INFO] - Dorking:$dork"
	echo "** Dorking: $dork ----------------------------------" >> $tempfile		
	curl -A "Mozilla/Firefox" -s --get --data-urlencode "q=$dork" http://ajax.googleapis.com/ajax/services/search/web?v=1.0 | egrep -o "http[^\"]+" | egrep -v "(www.youtube.com)|(google.com)|(/search\?q=cache)" >> $tempfile 
	
	# echo "$LINKS" | cut -d / -f 3 | cut -d : -f 1 | grep -v "^$"

	echo "[INFO] - Sleeping to avoid lockout"
	sleep $WAIT
	
done < "$filename"

# remove duplicates from file
awk '!seen[$0]++' $tempfile > $results

rm -f $tempfile
cat $results;

# if do not exist, create old and latest
mkdir archive
mkdir latest
mkdir diffed

echo " -----------------  DIFF WITH LATEST -----------------"
mv diffed/*.* archive/
diff $results latest/*.txt > diffed/$results-diff-with-latest.txt
mv latest/*.txt archive/
mv $results latest/


cat diffed/$results-diff-with-latest.txt




