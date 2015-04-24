#!/bin/bash

source /tmp/env/setuprc.sh

CINDER_CONF=/etc/cinder/cinder.conf 

sed -i '/^#/d' $CINDER_CONF
sed -i '/^\s*$/d' $CINDER_CONF

sed -i "/^connection/d" $CINDER_CONF

sed -i "/^\[database\]/a connection = mysql:\/\/cinder:$CINDER_DBPASS@$MGMT_NETIP_CONTROLLER\/cinder
" $CINDER_CONF

sed -i "/\[keystone_authtoken\]/a \\
auth_uri = http://$MGMT_NETIP_CONTROLLER:5000 \\
auth_host = cntrnode \\
auth_port = 35357 \\
auth_protocol = http \\
admin_tenant_name = service \\
admin_user = cinder \\
admin_password = $CINDER_PASS
" $CINDER_CONF

# 7. Configure Block Storage to use the RabbitMQ message broker
sed -i "/\[DEFAULT\]/a \\
rpc_backend = rabbit \\
rabbit_host = cntrnode \\
rabbit_port = 5672 \\
rabbit_userid = guest \\
rabbit_password = $RABBIT_PASS \\
" $CINDER_CONF

exit 0