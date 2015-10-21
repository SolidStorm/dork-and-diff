#!/bin/bash

site=.com
tempfile=temp.log
filename=dorks/dorks.txt
WAIT=5
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

        echo "[INFO] - Dorking:$dork"
        echo "" >> $tempfile
        #echo "" >> $tempfile
        echo "-----------------------" >> $tempfile
        echo "   $dork               " >> $tempfile
        echo "-----------------------" >> $tempfile

        curl -A "Mozilla/Firefox" -s --get --data-urlencode "q=$dork" http://ajax.googleapis.com/ajax/services/search/web?v=1.0 | egrep -o "http[^\"]+" | egrep -v "(www.youtube.com)|(google.com)|(/search\?q=cache)" >> $tempfile

        echo "" >> $tempfile
        # echo "$LINKS" | cut -d / -f 3 | cut -d : -f 1 | grep -v "^$"
        echo "[INFO] - Sleeping to avoid lockout"
        sleep $WAIT

done < "$filename"

