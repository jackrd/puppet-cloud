#!/bin/bash

FLOATING_IP_START=$1
FLOATING_IP_END=$2
EXTERNAL_NETWORK_GATEWAY=$3
EXTERNAL_NETWORK_CIDR=$4

TENANT_NETWORK_GATEWAY=$5
TENANT_NETWORK_CIDR=$6

neutron net-create ext-net --shared --router:external=True

neutron subnet-create ext-net --name ext-subnet   --allocation-pool start=$FLOATING_IP_START,end=$FLOATING_IP_END   --disable-dhcp --gateway $EXTERNAL_NETWORK_GATEWAY $EXTERNAL_NETWORK_CIDR

neutron net-create demo-net

neutron subnet-create demo-net --name demo-subnet   --gateway $TENANT_NETWORK_GATEWAY $TENANT_NETWORK_CIDR

neutron router-create demo-router

neutron router-interface-add demo-router demo-subnet

neutron router-gateway-set demo-router ext-net

exit 0





