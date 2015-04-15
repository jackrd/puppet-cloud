#!/bin/bash

CNTR_NODE=$1
GLANCE_PASS=$2
GLANCE_EMAIL=$3

source /tmp/neutron/env/admin-openrc.sh

echo $CNTR_NODE > /tmp/glance/glance_pre.txt
echo $GLANCE_PASS >> /tmp/glance/glance_pre.txt
echo $GLANCE_EMAIL >> /tmp/glance/glance_pre.txt

keystone user-create --name=glance --pass=$GLANCE_PASS  --email=$GLANCE_EMAIL &>> /tmp/glance/glance_pre.txt

keystone user-role-add --user=glance --tenant=service --role=admin &>> /tmp/glance/glance_pre.txt

SERVICE_ID=$(keystone service-list | awk '/ image / {print $2}')

if [ "$SERVICE_ID" == '' ]
then

keystone service-create --name=glance --type=image  --description="OpenStack Image Service" &>> /tmp/glance/glance_pre.txt

keystone endpoint-create  --service-id=$(keystone service-list | awk '/ image / {print $2}') --publicurl=http://$CNTR_NODE:9292  --internalurl=http://$CNTR_NODE:9292  --adminurl=http://$CNTR_NODE:9292 &>> /tmp/glance/glance_pre.txt

fi

exit 0