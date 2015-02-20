#!/bin/bash 
# 
# Count opal opal web services invocations by application
# using files prodiced by jobInfo-dump.sh
# Output file by-service is placed in a year directory of the opal-stats,
# for example /share/opal/opal-stats/2015

STATSBASE=/share/opal/opal-stats
ls $STATSBASE > /dev/null

if [ $# -eq 1 ]; then
    # check year
    YEAR=$1
else
    # show help
    echo "Usage: `basename $0` YEAR"
    echo "Find all files opaldb-DATE.out for a requested year and count opal invocations by application."
    echo "The output file is by-service"
    echo "       YEAR - 4 digit year. For example:  2013"
    exit
fi

if [ ! -d $STATSBASE ]; then
    echo "Directory for opal stats $STATSBASE does not exist"
    exit
fi

STATSDIR=$STATSBASE/$YEAR

if [ ! -d $STATSDIR ]; then
    echo "Directory $STATSDIR for opal stats for year $YEAR does not exist"
    exit
fi

c=`ls $STATSDIR/opaldb-$YEAR*out | wc -l`
echo "Processing $c files in $STATSDIR/"

cat $STATSDIR/opaldb-$YEAR*.out | awk '{print $1}' > app-names
sort app-names | grep -v service_name | uniq --count | awk '{print $2, $1}' > $STATSDIR/by-service
rm -rf app-names

