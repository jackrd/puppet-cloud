#!/bin/bash

nodetype=$1
INTERFACE_NAME=$2

if [ "$nodetype" == "networknode" ]
then
	service openvswitch-switch restart
	ovs-vsctl add-br br-int
	ovs-vsctl add-br br-ex
	ovs-vsctl add-port br-ex $INTERFACE_NAME
	ifdown br-ex
	ifup br-ex
fi

if [ "$nodetype" == "comptnode" ]
then
	service openvswitch-switch restart
	ovs-vsctl add-br br-int
fi

exit 0