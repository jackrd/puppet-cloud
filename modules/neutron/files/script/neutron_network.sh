#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

#####################################################################################
# Source the setup file to read in the environment variables

source /tmp/env/setuprc.sh
source /tmp/neutron/env/neutronrc.sh

# Configuration Files

SYSCTL_CONF=/etc/sysctl.conf
NEUTRON_CONF=/etc/neutron/neutron.conf
L3_AGENT_INI=/etc/neutron/l3_agent.ini
DHCP_AGENT_INI=/etc/neutron/dhcp_agent.ini
METADATA_AGENT_INI=/etc/neutron/metadata_agent.ini
ML2_CONF=/etc/neutron/plugins/ml2/ml2_conf.ini

sed -i '/^#/d' $SYSCTL_CONF
sed -i '/^\s*$/d' $SYSCTL_CONF

sed -i '/^#/d' $NEUTRON_CONF
sed -i '/^\s*$/d' $NEUTRON_CONF

sed -i '/^#/d' $L3_AGENT_INI
sed -i '/^\s*$/d' $L3_AGENT_INI

sed -i '/^#/d' $DHCP_AGENT_INI
sed -i '/^\s*$/d' $DHCP_AGENT_INI

sed -i '/^#/d' $METADATA_AGENT_INI
sed -i '/^\s*$/d' $METADATA_AGENT_INI

sed -i '/^#/d' $ML2_CONF
sed -i '/^\s*$/d' $ML2_CONF

#####################################################################################
# Configure network node
# Prerequisites
# Edit /etc/sysctl.conf

sed -i "/^net.ipv4.ip_forward/d" $SYSCTL_CONF
sed -i "/^net.ipv4.conf.all.rp_filter/d" $SYSCTL_CONF
sed -i "/^net.ipv4.conf.default.rp_filter/d" $SYSCTL_CONF

echo " " > $SYSCTL_CONF
sed -i "1 i net.ipv4.ip_forward=1" $SYSCTL_CONF
sed -i "1 i net.ipv4.conf.all.rp_filter=0" $SYSCTL_CONF
sed -i "1 i net.ipv4.conf.default.rp_filter=0" $SYSCTL_CONF

# Implement the changes
sysctl -p

#####################################################################################
# To configure the Networking common components
# The Networking common component configuration includes
# the authentication mechanism, message broker, and plug-in
# Configure Networking to use the Identity service for authentication

sed -i "/^auth_strategy/d" $NEUTRON_CONF
sed -i "/^rpc_backend/d" $NEUTRON_CONF
sed -i "/^rabbit_host/d" $NEUTRON_CONF
sed -i "/^rabbit_password/d" $NEUTRON_CONF
sed -i "/^core_plugin/d" $NEUTRON_CONF
sed -i "/^service_plugins/d" $NEUTRON_CONF
sed -i "/^allow_overlapping_ips/d" $NEUTRON_CONF

sed -i "/\[DEFAULT\]/a \\
auth_strategy = keystone \\
rpc_backend = neutron.openstack.common.rpc.impl_kombu \\
rabbit_host = $RABBIT_HOST \\
rabbit_password = $RABBIT_PASS \\
core_plugin = ml2 \\
service_plugins = router \\
allow_overlapping_ips = True \\
" $NEUTRON_CONF

sed -i "/^auth_uri/d" $NEUTRON_CONF
sed -i "/^auth_host/d" $NEUTRON_CONF
sed -i "/^auth_host/d" $NEUTRON_CONF
sed -i "/^admin_tenant_name/d" $NEUTRON_CONF
sed -i "/^admin_user/d" $NEUTRON_CONF
sed -i "/^admin_password/d" $NEUTRON_CONF

sed -i "/\[keystone_authtoken\]/a \\
auth_uri = http:\/\/$MGMT_NETIP_CONTROLLER:5000 \\
auth_host = $RABBIT_HOST\\
admin_tenant_name = service \\
admin_user = neutron \\
admin_password = $NEUTRON_PASS \\
" $NEUTRON_CONF

#####################################################################################
# To configure the Layer-3 (L3) agent

sed -i "/^interface_driver/d" $L3_AGENT_INI
sed -i "/^use_namespaces/d" $L3_AGENT_INI

sed -i "/\[DEFAULT\]/a \\
interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver \\
use_namespaces = True \\
" $L3_AGENT_INI

#####################################################################################
# To configure the DHCP agent

sed -i "/^interface_driver/d" $DHCP_AGENT_INI
sed -i "/^dhcp_driver/d" $DHCP_AGENT_INI
sed -i "/^use_namespaces/d" $DHCP_AGENT_INI

sed -i "/\[DEFAULT\]/a \\
interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver \\
dhcp_driver = neutron.agent.linux.dhcp.Dnsmasq \\
use_namespaces = True \\
" $DHCP_AGENT_INI

#####################################################################################
# To configure the metadata agent
# The metadata agent provides configuration information such as
# credentials for remote access to instances
# 1. Edit the /etc/neutron/metadata_agent.ini file

sed -i "/^auth_url/d" $METADATA_AGENT_INI
sed -i "/^auth_region/d" $METADATA_AGENT_INI
sed -i "/^admin_tenant_name/d" $METADATA_AGENT_INI
sed -i "/^admin_user/d" $METADATA_AGENT_INI
sed -i "/^admin_password/d" $METADATA_AGENT_INI
sed -i "/^nova_metadata_ip/d" $METADATA_AGENT_INI
sed -i "/^metadata_proxy_shared_secret/d" $METADATA_AGENT_INI

sed -i "/^\[DEFAULT\]/a \\
auth_url = http:\/\/$MGMT_NETIP_CONTROLLER:5000\/v2.0 \\
auth_region = regionOne \\
admin_tenant_name = service \\
admin_user = neutron \\
admin_password = $NEUTRON_METADATA_SECRET \\
nova_metadata_ip = $MGMT_NETIP_CONTROLLER \\
metadata_proxy_shared_secret = $NEUTRON_METADATA_SECRET \\
" $METADATA_AGENT_INI

#####################################################################################
# To configure the Modular Layer 2 (ML2) plug-in
# The ML2 plug-in uses the Open vSwitch (OVS) mechanism (agent)
# to build virtual networking framework for instances

sed -i "/^type_drivers/d" $ML2_CONF
sed -i "/^tenant_network_types/d" $ML2_CONF
sed -i "/^mechanism_drivers/d" $ML2_CONF
sed -i "/^tunnel_id_ranges/d" $ML2_CONF
sed -i "/^local_ip/d" $ML2_CONF
sed -i "/^tunnel_type/d" $ML2_CONF
sed -i "/^enbale_tunneling/d" $ML2_CONF
sed -i "/^firewall_driver/d" $ML2_CONF
sed -i "/^enable_security_group/d" $ML2_CONF


sed -i "/^\[ml2\]/a \\
type_drivers = gre \\
tenant_network_types = gre \\
mechanism_drivers = openvswitch \\
" $ML2_CONF

sed -i "/^\[ml2_type_gre\]/a \\
tunnel_id_ranges = 1:1000 \\
" $ML2_CONF

sed -i "/^\[ovs\]/a \\
local_ip = $INST_TUNIP_NETWORK \\
tunnel_type = gre \\
enable_tunneling = True \\
" $ML2_CONF

sed -i "/^\[securitygroup\]/a \\
firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver \\
enable_security_group = True \\
" $ML2_CONF

exit 0