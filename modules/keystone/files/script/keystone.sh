#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash


#####################################################################################
# Source the setup file to read in the environment variables
source /tmp/env/setuprc.sh

# Configuration File
KEYSTONE_CONF=/etc/keystone/keystone.conf

#####################################################################################
# Specify the location of the database in the configuration file
sed -i "/^connection/d" $KEYSTONE_CONF

sed -i "/^\[database\]/a connection = mysql:\/\/keystone:$KEYSTONE_DBPASS@$MGMT_NETIP_CONTROLLER\/keystone
" $KEYSTONE_CONF

# Delete the keystone.db
rm -f /var/lib/keystone/keystone.db

# Define an authorization token to use as a shared secret
#    between the Identity Service and other OpenStack services
sed -i "/^admin_token/d" $KEYSTONE_CONF

sed -i "
/^\[DEFAULT\]/a admin_token = $ADMIN_TOKEN
" $KEYSTONE_CONF

# Configure the log directory
sed -i "/^log_dir/d" $KEYSTONE_CONF

sed -i "
/^\[DEFAULT\]/a log_dir = \/var\/log\/keystone/
" $KEYSTONE_CONF

exit 0
