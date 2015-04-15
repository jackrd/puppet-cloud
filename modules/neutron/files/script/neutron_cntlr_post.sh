#!/bin/bash

FLOATING_IP_START=$1
FLOATING_IP_END=$2
EXTERNAL_NETWORK_GATEWAY=$3
EXTERNAL_NETWORK_CIDR=$4

TENANT_NETWORK_GATEWAY=$5
TENANT_NETWORK_CIDR=$6

source /tmp/neutron/env/admin-openrc.sh

echo $FLOATING_IP_START > /tmp/neutron/neutron_cntlr_post.txt
echo $FLOATING_IP_END >> /tmp/neutron/neutron_cntlr_post.txt
echo $EXTERNAL_NETWORK_GATEWAY >> /tmp/neutron/neutron_cntlr_post.txt
echo $EXTERNAL_NETWORK_CIDR >> /tmp/neutron/neutron_cntlr_post.txt
echo $TENANT_NETWORK_GATEWAY >> /tmp/neutron/neutron_cntlr_post.txt
echo $TENANT_NETWORK_CIDR >> /tmp/neutron/neutron_cntlr_post.txt


neutron net-create ext-net --shared --router:external=True &>> /tmp/neutron/neutron_cntlr_post.txt

neutron subnet-create ext-net --name ext-subnet   --allocation-pool start=$FLOATING_IP_START,end=$FLOATING_IP_END   --disable-dhcp --gateway $EXTERNAL_NETWORK_GATEWAY $EXTERNAL_NETWORK_CIDR &>> /tmp/neutron/neutron_cntlr_post.txt

neutron net-create demo-net &>> /tmp/neutron/neutron_cntlr_post.txt

neutron subnet-create demo-net --name demo-subnet   --gateway $TENANT_NETWORK_GATEWAY $TENANT_NETWORK_CIDR &>> /tmp/neutron/neutron_cntlr_post.txt

neutron router-create demo-router &>> /tmp/neutron/neutron_cntlr_post.txt

neutron router-interface-add demo-router demo-subnet &>> /tmp/neutron/neutron_cntlr_post.txt

neutron router-gateway-set demo-router ext-net &>> /tmp/neutron/neutron_cntlr_post.txt

exit 0





