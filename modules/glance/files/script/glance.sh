#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

#####################################################################################
# Source the setup file to read in the environment variables
source /tmp/env/setuprc.sh

# Configuration File
GLANCE_API_CONF=/etc/glance/glance-api.conf
GLANCE_REG_CONF=/etc/glance/glance-registry.conf

#####################################################################################
# Specify the location of the database in the configuration file

sed -i "/^connection/d" $GLANCE_API_CONF $GLANCE_REG_CONF

sed -i "/^\[database\]/a connection = mysql:\/\/glance:$GLANCE_DBPASS@$MGMT_NETIP_CONTROLLER\/glance
" $GLANCE_API_CONF $GLANCE_REG_CONF


# Setup mysql to support utf8 and innodb
sed -i "/^rpc_backend/d" $GLANCE_API_CONF
sed -i "/^rabbit_host/d" $GLANCE_API_CONF
sed -i "/^rabbit_password/d" $GLANCE_API_CONF

# Configure the Image Service to use the message broker
sed -i "/^\[DEFAULT\]/a \\
rpc_backend = rabbit \\
rabbit_host = controller \\
rabbit_password = $RABBIT_PASS \\
" $GLANCE_API_CONF

# Configure the Image Service to use the Identity Service for authentication
sed -i "/^auth_uri/d" $GLANCE_API_CONF $GLANCE_REG_CONF
sed -i "/^auth_host/d" $GLANCE_API_CONF $GLANCE_REG_CONF
sed -i "/^admin_tenant_name/d" $GLANCE_API_CONF $GLANCE_REG_CONF
sed -i "/^admin_user/d" $GLANCE_API_CONF $GLANCE_REG_CONF
sed -i "/^admin_password/d" $GLANCE_API_CONF $GLANCE_REG_CONF
sed -i "/^flavor/d" $GLANCE_API_CONF $GLANCE_REG_CONF


sed -i "/^\[keystone_authtoken\]/a \\
auth_uri = http:\/\/$MGMT_NETIP_CONTROLLER:5000 \\
auth_host = controller \\
admin_tenant_name = service \\
admin_user = glance \\
admin_password = $GLANCE_PASS \\
flavor = keystone \\
" $GLANCE_API_CONF $GLANCE_REG_CONF

sed -i "/^\[pstate_deploy\]/a \\
flavor = keystone \\
" $GLANCE_API_CONF $GLANCE_REG_CONF

exit 0
