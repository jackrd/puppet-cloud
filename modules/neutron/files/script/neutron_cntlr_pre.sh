#!/bin/bash

CNTRNODE=$1
NEUTRON_PASS=$2
NEUTRON_EMAIL=$3

source /tmp/base/env/admin-openrc.sh

echo $CNTRNODE > /tmp/neutron/neutron_cntlr_pre.txt
echo $NEUTRON_PASS >> /tmp/neutron/neutron_cntlr_pre.txt
echo $NEUTRON_EMAIL >> /tmp/neutron/neutron_cntlr_pre.txt

sleep 20

keystone user-create --name neutron --pass $NEUTRON_PASS --email $NEUTRON_EMAIL &>> /tmp/neutron/neutron_cntlr_pre.txt

keystone user-role-add --user neutron --tenant service --role admin &>> /tmp/neutron/neutron_cntlr_pre.txt

SERVICE_ID=$(keystone service-list | awk '/ network / {print $2}') 

if [ "$SERVICE_ID" == '' ]
then

keystone service-create --name neutron --type network --description "OpenStack Networking" &>> /tmp/neutron/neutron_cntlr_pre.txt

keystone endpoint-create  --service-id  $(keystone service-list | awk '/ network / {print $2}') --publicurl http://$CNTRNODE:9696 --adminurl http://$CNTRNODE:9696 --internalurl http://$CNTRNODE:9696 &>> /tmp/neutron/neutron_cntlr_pre.txt

fi

exit 0