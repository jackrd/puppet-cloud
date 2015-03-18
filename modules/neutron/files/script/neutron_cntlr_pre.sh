#!/bin/bash

CNTRNODE=$1
NEUTRON_PASS=$2
NEUTRON_EMAIL=$3

keystone user-create --name neutron --pass $NEUTRON_PASS --email $NEUTRON_EMAIL

keystone user-role-add --user neutron --tenant service --role admin

SERVICE_ID=$(keystone service-list | awk '/ network / {print $2}')

if [ "$SERVICE_ID" == '' ]
then

keystone service-create --name neutron --type network --description "OpenStack Networking"

keystone endpoint-create  --service-id  $(keystone service-list | awk '/ network / {print $2}') --publicurl http://$CNTRNODE:9696 --adminurl http://$CNTRNODE:9696 --internalurl http://$CNTRNODE:9696

fi

exit 0