#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash


#####################################################################################
# Source the setup file to read in the environment variables
source /tmp/setuprc.sh

# Configuration File
CINDER_CONF=/etc/cinder/cinder.conf

#####################################################################################
# Configure a Block Storage service controller
# 2. Configure Block Storage to use your database
sed -i "/^connection/d" $CINDER_CONF

sed -i "/^\[database\]/a \\
connection = mysql:\/\/cinder:$CINDER_DBPASS@$MGMT_NETIP_CONTROLLER/cinder
" $CINDER_CONF

# 6. Edit the /etc/cinder/cinder.conf configuration file and 
# add this section for keystone credentials

sed -i "/^auth_uri/d" $CINDER_CONF
sed -i "/^auth_host/d" $CINDER_CONF
sed -i "/^auth_port/d" $CINDER_CONF
sed -i "/^auth_protocol/d" $CINDER_CONF
sed -i "/^admin_tenant_name/d" $CINDER_CONF
sed -i "/^admin_user/d" $CINDER_CONF
sed -i "/^admin_password/d" $CINDER_CONF

sed -i "/^\[keystone_authtoken\]/a \\
auth_uri = http://$MGMT_NETIP_CONTROLLER:5000 \\
auth_host = controller \\
auth_port = 35357 \\
auth_protocol = http \\
admin_tenant_name = service \\
admin_user = cinder \\
admin_password = $CINDER_PASS
" $CINDER_CONF

# 7. Configure Block Storage to use the RabbitMQ message broker
sed -i "/^rpc_backend/d" $CINDER_CONF
sed -i "/^rabbit_host/d" $CINDER_CONF
sed -i "/^rabbit_port/d" $CINDER_CONF
sed -i "/^rabbit_userid/d" $CINDER_CONF
sed -i "/^rabbit_password/d" $CINDER_CONF


sed -i "/^\[DEFAULT\]/a \\
rpc_backend = rabbit \\
rabbit_host = controller \\
rabbit_port = 5672 \\
rabbit_userid = guest \\
rabbit_password = RABBIT_PASS \\
" $CINDER_CONF

exit 0