#/bin/bash

# Run this scirpt to process opal/apache logs for a given year/month and create stats.
# Arguments: year (4 digit) and month (2 digit). 
# Default: (no arguments) do  processing for a previous month from a current date
# Run as a cron job at the beginning of a month

if [ $# -eq 1 ]; then
    # show help
    echo "Usage: `basename $0` [YEAR MONTH]"
    echo "Run logs processing scripts for a previous month of a current year (when all logs are collected)."
    echo "If both YEAR and MONTH are provided run processing for specified values."
    echo "The output files will be placed in \$YEAR/"
    echo "    YEAR  - 4 digit year. For example 2014"
    echo "    MONTH - 2 digit month. For example 01 for January"
    exit
elif [ $# -eq 2 ]; then
    # get year and month from arguments
    YEAR=$1
    MONTH=$2
else
    # find current year and prev month
    YEAR=`date +%Y`
    MONTH=`date --date "now -1 month" "+%m"`
fi

### Definitions ###

# set default variables
SetDefaults () {
    # directories for stata outputs
    STATSBASE=/share/opal/opal-stats
    STATS=/share/opal/opal-stats/$YEAR
    # directory  with stats scripts
    BIN=/opt/opal/bin
}

# sets working directory for all stats and logs
SetupWD () {
    if [ ! -d $STATS ]; then
        mkdir -p $STATS
    fi
    cd $STATS
}


# Creates opal jobs counts by service for a specified year/month
CountOpalJobs () {
    # dump opal jobs for month, creates opaldb-$YEAR-$MONTH.[out, err] files
    $BIN/jobInfo-dump.sh $YEAR $MONTH
    /bin/mv opaldb-$YEAR-$MONTH.* $STATS

    # update opal invocations count, creates opal-onvocations file
    count=`wc -l $STATS/opaldb-$YEAR*.out | grep total | awk '{print $1}'`
    header=`ls $STATS/opaldb-$YEAR*.out | wc -l`
    let "total = count - header"
    echo $total > $STATS/opal-invocations

    # update counts by service up to current month, creates by-service file
    $BIN/countByService.sh $YEAR
}

# Create web services access geolocation counts by USstate/country from unique host ips 
# taken from apache logs for a specified month
CountIPs () {
    # parse apache logs for year/month and get uniq IPs, creates ips-$YEAR-$MONTH file with uniq IPs
    $BIN/getIP.sh $YEAR $MONTH

    # process uniq IPs file to get geolocation by US state or country, creates ips-$YEAR-$WORLD-[us,world] files
    $BIN/getGeoIP.py ips-$YEAR-$MONTH -format=none
    /bin/mv ips-$YEAR-$MONTH* $STATS
}

# Create total counts for opal web services invocations, and us/world access by unique IP.
# Add counts from a second server if exist
UpdateAllCounts () {
    # update counts, will add stats from host
    HOST1=$STATSBASE/rocce-vm3/$YEAR

    # update opal invocations count
    FILE=by-service
    if [ -f $HOST1/$FILE ]; then
        /bin/cat $STATS/$FILE $HOST1/$FILE > by-service-all
    else 
        /bin/cat $STATS/$FILE > by-service-all
    fi
    $BIN/combineGeoCount.py by-service-all $STATS/by-service-count
    rm -rf  by-service-all

    # check if second server counts are available
    if [ -d $HOST1 ]; then
        us1=$HOST1/ips-$YEAR-??-us
        world1=$HOST1/ips-$YEAR-??-world
    else
        us1=
        workd1=
    fi

    # create US count by unique IP
    /bin/cat $STATS/ips-$YEAR-??-us $us1 > us
    $BIN/combineGeoCount.py us $STATS/ips-us-sum
    rm -rf us

    # create world count by unique IP
    /bin/cat $STATS/ips-$YEAR-??-world $world1 > world
    $BIN/combineGeoCount.py world  $STATS/ips-world-sum
    rm -rf world
}

### Main ###
SetDefaults
SetupWD
CountOpalJobs
CountIPs
UpdateAllCounts
