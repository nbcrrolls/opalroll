#!/bin/bash
#
# Purpose: bring opal stats from host specified in FQDN
# on a remove host ssh keys  must be set to allow scp connection

if [ $# -eq 1 ]; then
    # check year
    FQDN=$1
else
    # show help
    echo "Usage: `basename $0` FQDN"
    echo "        FQDN - host from which to fetch opal stats."
    exit
fi

SetDefaults () {
    # directories for stata outputs
    STATSBASE=/share/opal/opal-stats
    STATS=/share/opal/opal-stats/$YEAR
    # directory  with stats scripts
    BIN=/opt/opal/bin
    YEAR=`date +%Y`
    HOST=`echo $FQDN | awk -F. '{print $1}'`
}

# bring opal stats logs from rocce-vm3

FetchLogs () {
    # mount opal-stats directory 
    ls $STATS > /dev/null

    if [ ! -d $STATS ]; then
        mkdir -p $STATS
    fi

    if [ ! -d $STATSBASE/$HOST ]; then
        mkdir -p $STATSBASE/$HOST
    fi

    # fetch stats form a remove host
    REMOTEDIR=/root/opal-stats   #FIXME: set to the same base on all hosts as in $STATSBASE
    cd $STATSBASE/$HOST
    scp root@$FQDN:$REMOTEDIR/$HOST-$YEAR.tar.gz .
    tar xzf $HOST-$YEAR.tar.gz

    # mail log file
    MSG=/tmp/message
    TO=nadya@sdsc.edu
    ADDR=`rocks list host attr localhost | grep opal_public_fqdn | awk '{print $3}'`
    echo "Collection of opal stats from $FQDN, run on `date +%Y-%m-%d ` " > $MSG
    mailx -r root@$ADDR -s "collection of opal stats from $HOST" $TO < $MSG
    rm -rf $MSG
}

##### Main #####
SetDefaults
FetchLogs
