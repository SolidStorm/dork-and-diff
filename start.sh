#!/bin/bash

site=.com
mkdir -p output/
currentdate=`date "+%s"`
tempfile=output/${currentdate}_temp.log
results=output/results.txt
dorklist=dorks/dorks.txt
#dorklist=dorks/dorks.min

if [ -z "$1" ]
then
        echo "No argument 1 supplied (country or dork site:)"
else
        # TODO - do not run as root
                site=$1
fi

./dork-and-diff.sh $tempfile $site $dorklist


