#!/bin/bash

source /tmp/neutron/env/neutronrc.sh

ovs-vsctl add-br br-int
ovs-vsctl add-br br-ex
ovs-vsctl add-port br-ex $INTERFACE_NAME

exit 0