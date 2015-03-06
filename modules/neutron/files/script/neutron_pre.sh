#!/bin/bash

source /tmp/env/setuprc.sh

source /tmp/neutron/env/neutronrc.sh

keystone user-create --name neutron --pass $NEUTRON_ADMIN_PASSWORD --email $NEUTRON_EMAIL

keystone user-role-add --user neutron --tenant service --role admin

keystone service-create --name neutron --type network --description "OpenStack Networking"

keystone endpoint-create \
  --service-id $(keystone service-list | awk '/ network / {print $2}') \
  --publicurl http://$MGMT_NETIP_CONTROLLER:9696 \
  --adminurl http://$MGMT_NETIP_CONTROLLER:9696 \
  --internalurl http://$MGMT_NETIP_CONTROLLER:9696

exit 0