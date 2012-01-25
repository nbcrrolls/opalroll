#!/bin/bash

ANT=/opt/rocks/bin/ant
OPALXML=/opt/opal/build.xml
OPALCONFIG=/opt/opal/deployed

# deploy test applications
$ANT -f $OPALXML deploy -DserviceName=cat   -DappConfig=$OPALCONFIG/cat_config.xml
$ANT -f $OPALXML deploy -DserviceName=date  -DappConfig=$OPALCONFIG/date_config.xml

# deploy meta services  
# ant -f $OPALXML deploy -DserviceName=APBSParallelMeta -DappConfig=$OPALCONFIG/apbs_parallel_meta_config.xml
# ant -f $OPALXML deploy -DserviceName=PDB2PQRMeta      -DappConfig=$OPALCONFIG/pdb2pqr_meta_config.xml 

# deploy existing services  

