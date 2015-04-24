#!/bin/bash

CNTRNODE=$1
CINDER_PASS=$2
CINDER_EMAIL=$3

source /tmp/base/env/admin-openrc.sh

echo $CNTRNODE > /tmp/cinder/cinder_cntr_pre.txt
echo $CINDER_PASS >> /tmp/cinder/cinder_cntr_pre.txt
echo $CINDER_EMAIL >> /tmp/cinder/cinder_cntr_pre.txt

sleep 20

keystone user-create --name cinder --pass $CINDER_PASS --email $CINDER_EMAIL &>> /tmp/cinder/cinder_cntr_pre.txt

keystone user-role-add --user cinder --tenant service --role admin &>> /tmp/cinder/cinder_cntr_pre.txt

SERVICE_ID=$(keystone service-list | awk '/ volume / {print $2}') 

if [ "$SERVICE_ID" == '' ]
then

keystone service-create --name cinder --type volume --description "OpenStack Block Storage" &>> /tmp/cinder/cinder_cntr_pre.txt
keystone endpoint-create \
  --service-id=$(keystone service-list | awk '/ volume / {print $2}') \
  --publicurl=http://$CNTRNODE:8776/v1/%\(tenant_id\)s \
  --internalurl=http://$CNTRNODE:8776/v1/%\(tenant_id\)s \
  --adminurl=http://$CNTRNODE:8776/v1/%\(tenant_id\)s

keystone service-create --name cinderv2 --type volumev2 --description "OpenStack Block Storage v2" &>> /tmp/cinder/cinder_cntr_pre.txt
keystone endpoint-create \
  --service-id=$(keystone service-list | awk '/ volumev2 / {print $2}') \
  --publicurl=http://$CNTRNODE:8776/v2/%\(tenant_id\)s \
  --internalurl=http://$CNTRNODE:8776/v2/%\(tenant_id\)s \
  --adminurl=http://$CNTRNODE:8776/v2/%\(tenant_id\)s
 
fi

exit 0