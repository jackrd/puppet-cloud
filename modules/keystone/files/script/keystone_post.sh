#!/bin/bash

source /tmp/env/setuprc.sh
source /tmp/keystone/env/keystonerc.sh

controller=$1

export OS_SERVICE_TOKEN=$ADMIN_TOKEN
export OS_SERVICE_ENDPOINT=http://$controller:35357/v2.0

keystone user-create --name=admin --pass=$ADMIN_PASS --email=$ADMIN_EMAIL

keystone role-create --name=admin

keystone tenant-create --name=admin --description="Admin Tenant"

keystone user-role-add --user=admin --tenant=admin --role=admin

keystone user-role-add --user=admin --role=_member_ --tenant=admin

keystone tenant-create --name=service --description="Service Tenant"

SERVICE_ID= $(keystone service-list | awk '/ identity / {print $2}')

if [ "$SERVICE_ID" == '0' ]
then

keystone service-create --name=keystone --type=identity  --description="OpenStack Identity"

keystone endpoint-create  --service-id=$SERVICE_ID   --publicurl=http://$controller:5000/v2.0   --internalurl=http://$controller:5000/v2.0   --adminurl=http://$controller:35357/v2.0

fi

unset OS_SERVICE_TOKEN OS_SERVICE_ENDPOINT

exit 0