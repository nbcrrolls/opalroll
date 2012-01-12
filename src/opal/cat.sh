#!/bin/bash

HOST=`hostname`
CAT=/bin/cat

while [ "$1" != "" ]; do
    case $1 in
        -input )  shift
                  input=$1
                  ;;
        * )       echo "Invalid argument in $@"
                  exit 1
    esac
    shift
done

cmd="$CAT $input"
echo "Execute host: $HOST"
echo "Execute command:" $cmd

if test -z "$input"; then
  echo "ERROR: no input file provided"
  exit 0
fi

$cmd

