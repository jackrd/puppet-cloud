#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

# Make sure only root can run tht script
if [ "$(id -u)" != "0" ]; then
   echo "You need to be 'root'." 1>&2
   exit 1
fi

#####################################################################################
# Start services on the storage nodes
echo "*************** Start services on the storage nodes ***************"
for service in \
    swift-object swift-object-replicator swift-object-updater swift-object-auditor \
    swift-container swift-container-replicator swift-container-updater swift-container-auditor \
    swift-account swift-account-replicator swift-account-reaper swift-account-auditor;
do \
    service $service start;
done

# Note: To start all swift services at once, run the command "swift-init all start"

echo "#####################################################################################"
echo;
echo "Swift services are started."
echo;
echo "#####################################################################################"
