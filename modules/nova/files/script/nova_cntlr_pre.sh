#!/bin/bash

source /tmp/env/setuprc.sh
source /tmp/env/nova/novarc.sh

cntrnode=$1

keystone user-create --name=nova --pass=$NOVA_PASS --email=$NOVA_EMAIL

keystone user-role-add --user=nova --tenant=service --role=admin

keystone service-create --name=nova --type=compute  --description="OpenStack Compute"

SERVICE_ID=$(keystone service-list | awk '/ compute / {print $2}')

if [ "$SERVICE_ID" == '0' ]
then

keystone endpoint-create --service-id= $SERVICE_ID  --publicurl=http://$cntrnode:8774/v2/%\(tenant_id\)s --internalurl=http://$cntrnode:8774/v2/%\(tenant_id\)s --adminurl=http://$cntrnode:8774/v2/%\(tenant_id\)s

fi

exit 0