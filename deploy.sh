#!/bin/bash
#
# Clem
#
# this is a helper script which can be used to compile all the software stack 
# necessary to run the NBCR web service gateway.
#
# 1. Install rocks cluster _without_ the java roll
# 2. Install opalrool on it
# 3. go in an empty folder and then run this script from there


 
application="pdb2pqr browndye apbs vmd openbabel gromacs cadd namd meme autodock "
 
 
for i in $application; do
 
    if [ -d $i ]; then
        cd $i && git pull && cd .. || \
            exit 1;
    else
        git clone https://github.com/nbcrrolls/$i.git || \
            exit 1;
    fi
 
    cd $i || exit 1
 
    if [ -f bootstrap.sh ]; then
        ./bootstrap.sh || exit 1
    fi
 
    make roll && \
        rocks add roll $i*.iso && \
        rocks enable roll  `rocks list roll |grep $i |sed 's/\(.*\):.*/\1/'` || \
        exit 1
    cd ..
done
 
cd /export/rocks/install
rocks create distro
