#!/bin/bash

CNTRNODE=$1
NOVA_PASS=$2
NOVA_EMAIL=$3

keystone user-create --name=nova --pass=$NOVA_PASS --email=$NOVA_EMAIL

keystone user-role-add --user=nova --tenant=service --role=admin

SERVICE_ID=$(keystone service-list | awk '/ compute / {print $2}')

if [ "$SERVICE_ID" == '' ]
then

keystone service-create --name=nova --type=compute  --description="OpenStack Compute"

keystone endpoint-create --service-id=$(keystone service-list | awk '/ compute / {print $2}')  --publicurl=http://$CNTRNODE:8774/v2/%\(tenant_id\)s --internalurl=http://$CNTRNODE:8774/v2/%\(tenant_id\)s --adminurl=http://$CNTRNODE:8774/v2/%\(tenant_id\)s

fi

exit 0