#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

#####################################################################################
# Source the setup file to read in the environment variables
source /tmp/env/setuprc.sh
source /tmp/nova/env/novarc.sh

# Configuration File
NOVA_CONF=/etc/nova/nova.conf

sed -i '/^#/d' $NOVA_CONF
sed -i '/^\s*$/d' $NOVA_CONF

#####################################################################################
# Specify the location of the database in the configuration file
sed -i "/^connection/d" $NOVA_CONF
sed -i "/^\[database\]/d" $NOVA_CONF

sed -i "1 i \[database\]" $NOVA_CONF

sed -i "/^\[database\]/a \\
connection = mysql:\/\/nova:$NOVA_DBPASS@$MGMT_NETIP_CONTROLLER/nova
" $NOVA_CONF

# Configure the Compute service to use the RabbitMQ message broker
sed -i "/^rpc_backend/d" $NOVA_CONF
sed -i "/^rabbit_host/d" $NOVA_CONF
sed -i "/^rabbit_password/d" $NOVA_CONF
sed -i "/^my_ip/d" $NOVA_CONF
sed -i "/^vncserver_listen/d" $NOVA_CONF
sed -i "/^vncserver_proxyclient_address/d" $NOVA_CONF
sed -i "/^auth_strategy/d" $NOVA_CONF

sed -i "/^\[DEFAULT\]/a \\
rpc_backend = rabbit \\
rabbit_host = $RABBIT_HOST \\
rabbit_password = $RABBIT_PASS \\
my_ip = $MGMT_NETIP_CONTROLLER\\
vncserver_listen = $MGMT_NETIP_CONTROLLER\\
vncserver_proxyclient_address = $MGMT_NETIP_CONTROLLER\\
auth_strategy = keystone 
" $NOVA_CONF

sed -i "/^\[keystone_authtoken\]/d" $NOVA_CONF
sed -i "/^auth_uri/d" $NOVA_CONF
sed -i "/^auth_host/d" $NOVA_CONF
sed -i "/^auth_port/d" $NOVA_CONF
sed -i "/^auth_protocol/d" $NOVA_CONF
sed -i "/^admin_tenant_name/d" $NOVA_CONF
sed -i "/^admin_user/d" $NOVA_CONF
sed -i "/^admin_password/d" $NOVA_CONF

sed -i "1 i  \[keystone_authtoken\]" $NOVA_CONF

sed -i "/^\[keystone_authtoken\]/a \\
auth_uri = http://$MGMT_NETIP_CONTROLLER:5000 \\
auth_host = $MGMT_NETIP_CONTROLLER\\
auth_port = 35357 \\
auth_protocol = http \\
admin_tenant_name = service \\
admin_user = nova \\
admin_password = $NOVA_PASS
" $NOVA_CONF


exit 0