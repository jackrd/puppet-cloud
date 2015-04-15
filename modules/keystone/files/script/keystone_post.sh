#!/bin/bash

controller=$1
ADMIN_PASS=$2
ADMIN_EMAIL=$3

echo $controller > /tmp/keystone/keystone_post.txt
echo $ADMIN_PASS >> /tmp/keystone/keystone_post.txt
echo $ADMIN_EMAIL >> /tmp/keystone/keystone_post.txt
echo $OS_SERVICE_TOKEN >> /tmp/keystone/keystone_post.txt
echo $OS_SERVICE_ENDPOINT >> /tmp/keystone/keystone_post.txt

sleep 51

keystone user-create --name=admin --pass=$ADMIN_PASS --email=$ADMIN_EMAIL &>> /tmp/keystone/keystone_post.txt


keystone role-create --name=admin &>> /tmp/keystone/keystone_post.txt


keystone tenant-create --name=admin --description="Admin Tenant" &>> /tmp/keystone/keystone_post.txt


keystone user-role-add --user=admin --tenant=admin --role=admin &>> /tmp/keystone/keystone_post.txt


keystone user-role-add --user=admin --tenant=admin --role=_member_ &>> /tmp/keystone/keystone_post.txt


keystone tenant-create --name=service --description="Service Tenant" &>> /tmp/keystone/keystone_post.txt


SERVICE_ID= $(keystone service-list | awk '/ identity / {print $2}')

if [ "$SERVICE_ID" == '' ]
then

keystone service-create --name=keystone --type=identity  --description="OpenStack Identity" &>> /tmp/keystone/keystone_post.txt


keystone endpoint-create  --service-id=$(keystone service-list | awk '/ identity / {print $2}')   --publicurl=http://$controller:5000/v2.0   --internalurl=http://$controller:5000/v2.0   --adminurl=http://$controller:35357/v2.0 &>> /tmp/keystone/keystone_post.txt


fi

exit 0