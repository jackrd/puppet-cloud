#!/bin/bash

source /tmp/base/env/admin-openrc.sh
source /tmp/neutron/env/neutronrc.sh

neutron net-create ext-net --shared --router:external=True

neutron subnet-create ext-net --name ext-subnet   --allocation-pool start=$FLOATING_IP_START,end=$FLOATING_IP_END   --disable-dhcp --gateway $EXTERNAL_NETWORK_GATEWAY $EXTERNAL_NETWORK_CIDR

neutron net-create demo-net

neutron subnet-create demo-net --name demo-subnet   --gateway $TENANT_NETWORK_GATEWAY $TENANT_NETWORK_CIDR

neutron router-create demo-router

neutron router-interface-add demo-router demo-subnet

neutron router-gateway-set demo-router ext-net

exit 0





