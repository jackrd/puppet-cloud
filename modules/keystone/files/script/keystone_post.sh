#!/bin/bash


controller=$1
ADMIN_PASS=$2
ADMIN_EMAIL=$3

keystone user-create --name=admin --pass=$ADMIN_PASS --email=$ADMIN_EMAIL

keystone role-create --name=admin

keystone tenant-create --name=admin --description="Admin Tenant"

keystone user-role-add --user=admin --tenant=admin --role=admin

keystone user-role-add --user=admin --tenant=admin --role=_member_ 

keystone tenant-create --name=service --description="Service Tenant"

SERVICE_ID= $(keystone service-list | awk '/ identity / {print $2}')

if [ "$SERVICE_ID" == '' ]
then

keystone service-create --name=keystone --type=identity  --description="OpenStack Identity"

keystone endpoint-create  --service-id=$(keystone service-list | awk '/ identity / {print $2}')   --publicurl=http://$controller:5000/v2.0   --internalurl=http://$controller:5000/v2.0   --adminurl=http://$controller:35357/v2.0

fi

exit 0