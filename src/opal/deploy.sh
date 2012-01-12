#!/bin/bash

OPALXML=/opt/opal/build.xml
OPALCONFIG=/opt/opal/configs

# deploy test applications
ant -f $OPALXML deploy -DserviceName=cat   -DappConfig=$OPALCONFIG/cat_config.xml
ant -f $OPALXML deploy -DserviceName=date  -DappConfig=$OPALCONFIG/date_config.xml

# deploy meta services  
# ant -f $OPALXML deploy -DserviceName=APBSParallelMeta -DappConfig=$OPALCONFIG/apbs_parallel_meta_config.xml
# ant -f $OPALXML deploy -DserviceName=PDB2PQRMeta      -DappConfig=$OPALCONFIG/pdb2pqr_meta_config.xml 

# deploy existing services  

pdb2pqr_bin=/opt/pdb2pqr
if test -e $pdb2pqr_bin; then
    ant -f $OPALXML deploy -DserviceName=PDB2PQR -DappConfig=$OPALCONFIG/pdb2pqr_config.xml
fi


apbs_bin=/opt/apbs/bin/apbs
if test -e $apbs_bin; then
    ant -f $OPALXML deploy -DserviceName=APBS -DappConfig=$OPALCONFIG/apbs_config.xml
fi

mast_bin=/opt/meme/bin/mast
if test -e $mast_bin; then
    ant -f $OPALXML deploy -DserviceName=MAST -DappConfig=$OPALCONFIG/mast_config.xml
fi  

meme_bin=/opt/meme/bin/meme
if test -e $meme_bin; then
    ant -f $OPALXML deploy -DserviceName=MEME -DappConfig=$OPALCONFIG/meme_config.xml
fi  

autogrid=/opt/bio/autodocksuite/bin/autogrid4
if test -e $autogrid; then
    ant -f $OPALXML deploy -DserviceName=AutoGrid -DappConfig=$OPALCONFIG/autogrid_config.xml
fi  

autodock=/opt/bio/autodocksuite/bin/autodock4
if test -e $autodock; then
    ant -f $OPALXML deploy -DserviceName=AutoDock -DappConfig=$OPALCONFIG/autodock_config.xml
fi  

babel=/opt/bio/bin/babel
if test -e $babel; then
    ant -f $OPALXML deploy -DserviceName=babel -DappConfig=$OPALCONFIG/babel_config.xml
fi  
