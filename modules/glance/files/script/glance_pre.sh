#!/bin/bash

source /tmp/env/setuprc.sh
source /tmp/glance/env/glancerc.sh

CNTR_NODE=$1

keystone user-create --name=glance --pass=$GLANCE_PASS  --email=$GLANCE_EMAIL

keystone user-role-add --user=glance --tenant=service --role=admin

keystone service-create --name=glance --type=image  --description="OpenStack Image Service"

SERVICE_ID=$(keystone service-list | awk '/ image / {print $2}')

if [ "$SERVICE_ID" == '0' ]
then

keystone endpoint-create  --service-id=$SERVICE_ID --publicurl=http://$CNTR_NODE:9292  --internalurl=http://$CNTR_NODE:9292  --adminurl=http://$CNTR_NODE:9292

fi

exit 0