#!/bin/bash

nodetype=$1
PUBLIC_INTERFACE_NAME=$2

echo $nodetype > /tmp/neutron/neutron_ovs.txt
echo $PUBLIC_INTERFACE_NAME > /tmp/neutron/neutron_ovs.txt

sleep 50

if [ "$nodetype" == "networknode" ]
then
	#service openvswitch-switch restart
	ovs-vsctl add-br br-int &>> /tmp/neutron/neutron_ovs.txt
	ovs-vsctl add-br br-ex &>> /tmp/neutron/neutron_ovs.txt
	ovs-vsctl add-port br-ex $PUBLIC_INTERFACE_NAME &>> /tmp/neutron/neutron_ovs.txt
	ifdown em2 
	ifup em2
	ifdown $PUBLIC_INTERFACE_NAME
	ifup $PUBLIC_INTERFACE_NAME
	ifdown br-ex
	ifup br-ex
fi

if [ "$nodetype" == "comptnode" ]
then
	#service openvswitch-switch restart
	ovs-vsctl add-br br-int &>> /tmp/neutron/neutron_ovs.txt
fi

exit 0