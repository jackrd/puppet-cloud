#!/bin/bash

source /tmp/env/setuprc.sh
source /tmp/neutron/env/neutronrc.sh


keystone user-create --name neutron --pass $NEUTRON_PASS --email $NEUTRON_EMAIL

keystone user-role-add --user neutron --tenant service --role admin

keystone service-create --name neutron --type network --description "OpenStack Networking"

SERVICE_ID=$(keystone service-list | awk '/ network / {print $2}')

if [ "$SERVICE_ID" == '0' ]
then

keystone endpoint-create  --service-id  $SERVICE_ID --publicurl http://$MGMT_NETIP_CONTROLLER:9696 --adminurl http://$MGMT_NETIP_CONTROLLER:9696 --internalurl http://$MGMT_NETIP_CONTROLLER:9696

fi

exit 0