#!/bin/bash

site=.com
tempfile=output/results.log
resultsfile_csv="${tempfile}.csv"
filename=dorks/dorks.txt
WAIT=5
searchengine="google-ajax-api"
currentdate=`date "+%Y%m%d-%H%M%S"`
# csv output formatting
#date|dork|link|searchengine|confirmed|other

mkdir output


if [ -z "$1" ]
then
        echo "No argument 1 supplied (temp file)"
else
        # TODO - do not run as root
                tempfile=$1
fi

if [ -z "$2" ]
then
        echo "No argument 2 supplied (site: dork)"
else
        # TODO - do not run as root
        site=$2
fi

if [ -z "$3" ]
then
        echo "No argument 3 supplied (dork list, taking dorks.txt)"
else
        # TODO - do not run as root
        filename=$3
fi

if [ -z "$4" ]
then
        echo "No argument 4 supplied (wait time)"
else
        # TODO - do not run as root
        WAIT=$4
fi


while read -r line
do
        dork="site:$site $line"

        curl -A "Mozilla/Firefox" -s --get --data-urlencode "q=$dork" http://ajax.googleapis.com/ajax/services/search/web?v=1.0 | egrep -o "http[^\"]+" | egrep -v "(www.youtube.com)|(google.com)|(/search\?q=cache)" > $tempfile

	################ csv formatting
	# date|dork|link|searchengine|confirmed|other
	while IFS='' read -r line || [[ -n "$line" ]]; do
    		echo "$currentdate|$dork|$line|$searchengine|-|-|" >> $resultsfile_csv
	done < "$tempfile"	

        echo "[INFO] - Sleeping to avoid lockout"
        sleep $WAIT

done < "$filename"

rm -f $tempfile


exit

