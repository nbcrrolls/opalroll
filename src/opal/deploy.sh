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

