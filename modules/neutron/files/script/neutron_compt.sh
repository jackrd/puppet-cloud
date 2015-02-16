#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

#####################################################################################
# Source the setup file to read in the environment variables

source /tmp/env/setuprc.sh


# Configuration File
SYSCTL_CONF=/etc/sysctl.conf
NEUTRON_CONF=/etc/neutron/neutron.conf
ML2_CONF=/etc/neutron/plugins/ml2/ml2_conf.ini
NOVA_CONF=/etc/nova/nova.conf

#####################################################################################
# Configure compute node
# Prerequisites
# Edit /etc/sysctl.conf
sed -i "
/^#net.ipv4.conf.all.rp_filter=.*$/s/^.*$/net.ipv4.conf.all.rp_filter=0 \\
/^#net.ipv4.conf.default.rp_filter=.*$/s/^.*$/net.ipv4.conf.default.rp_filter=0 \\
" $SYSCTL_CONF

# Implement the changes
sysctl -p

#####################################################################################
# To configure the Networking common components
# The Networking common component configuration includes
# the authentication mechanism, message broker, and plug-in
# Configure Networking to use the Identity service for authentication

sed -i "/^auth_strategy/d" $NEUTRON_CONF

sed -i  "/^\[DEFAULT\]/a \\
auth_strategy = keystone \\
" $NEUTRON_CONF

sed -i "/^auth_uri/d" $NEUTRON_CONF
sed -i "/^auth_host/d" $NEUTRON_CONF
sed -i "/^admin_tenant_name/d" $NEUTRON_CONF
sed -i "/^admin_user/d" $NEUTRON_CONF
sed -i "/^admin_password/d" $NEUTRON_CONF

sed -i "/^\[keystone_authtoken\]/a \\
auth_uri = http:\/\/$MGMT_NETIP_CONTROLLER:5000
auth_host = controller \\
admin_tenant_name = service \\
admin_user = neutron \\
admin_password = $NEUTRON_ADMIN_PASSWORD \\
" $NEUTRON_CONF


# Configure Networking to use the message broker
sed -i "/^rpc_backend/d" $NEUTRON_CONF
sed -i "/^rabbit_host/d" $NEUTRON_CONF
sed -i "/^rabbit_password/d" $NEUTRON_CONF

sed -i "/^\[DEFAULT\]/a \\
rpc_backend = neutron.openstack.common.rpc.impl_kombu \\
rabbit_host = controller \\
rabbit_password = RABBIT_PASS \\
" $NEUTRON_CONF

# Configure Networking to use the Modular Layer 2 (ML2) plug-in and associated services
sed -i "/^core_plugin/d" $NEUTRON_CONF
sed -i "/^service_plugins/d" $NEUTRON_CONF
sed -i "/^allow_overlapping_ips/d" $NEUTRON_CONF

sed -i "/^\[DEFAULT\]/a \\
core_plugin = ml2 \\
service_plugins = router \\
allow_overlapping_ips = True \\
" $NEUTRON_CONF

#####################################################################################
# To configure the Modular Layer 2 (ML2) plug-in
# The ML2 plug-in uses the Open vSwitch (OVS) mechanism (agent)
# to build virtual networking framework for instances
sed -i "/^type_drivers/d" $ML2_CONF
sed -i "/^tenant_network_types/d" $ML2_CONF
sed -i "/^mechanism_drivers/d" $ML2_CONF
sed -i "/^tunnel_id_ranges/d" $ML2_CONF
sed -i "/^enable_security_group/d" $ML2_CONF

sed -i "/^\[ml2\]/a \\
type_drivers = gre \\
tenant_network_types = gre \\
mechanism_drivers = openvswitch \\
tunnel_id_ranges = 1:1000 \\
enable_security_group = True \\
" $ML2_CONF

sed -i "/^local_ip/d" $ML2_CONF
sed -i "/^tunnel_type/d" $ML2_CONF
sed -i "/^enable_tunneling/d" $ML2_CONF

sed -i "/^\[ovs\]/a \\
local_ip = $INST_TUNIP_COMPUTE1 \\
tunnel_type = gre \\
enable_tunneling = True
" $ML2_CONF

sed -i "/^firewall_driver/d" $ML2_CONF

sed -i "/^\[securitygroup\]/a \\
firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver \\
" $ML2_CONF

#####################################################################################
# To configure the Open vSwitch (OVS) service
# The OVS service provides the underlying virtual networking framework for instances.
# The integration bridge br-int handles internal instance network traffic within OVS.
# The external bridge br-ex handles external instance network traffic within OVS.
#  Restart the OVS service
# service openvswitch-switch restart

#  Add the integration bridge
#ovs-vsctl add-br br-int


sed -i "/^network_api_class/d" $NOVA_CONF
sed -i "/^neutron_url/d" $NOVA_CONF
sed -i "/^neutron_auth_strategy/d" $NOVA_CONF
sed -i "/^neutron_admin_tenant_name/d" $NOVA_CONF
sed -i "/^neutron_admin_username/d" $NOVA_CONF
sed -i "/^neutron_admin_password/d" $NOVA_CONF
sed -i "/^neutron_admin_auth_url/d" $NOVA_CONF
sed -i "/^linuxnet_interface_driver/d" $NOVA_CONF
sed -i "/^firewall_driver/d" $NOVA_CONF
sed -i "/^security_group_api/d" $NOVA_CONF

sed -i "/\[DEFAULT\]/a \\
network_api_class = nova.network.neutronv2.api.API \\
neutron_url = http://$MGMT_NETIP_CONTROLLER:9696 \\
neutron_auth_strategy = keystone \\
neutron_admin_tenant_name = service \\
neutron_admin_username = neutron \\
neutron_admin_password = $NEUTRON_ADMIN_PASSWORD \\
neutron_admin_auth_url = http://$MGMT_NETIP_CONTROLLER:35357/v2.0 \\
linuxnet_interface_driver = nova.network.linux_net.LinuxOVSInterfaceDriver \\
firewall_driver = nova.virt.firewall.NoopFirewallDriver \\
security_group_api = neutron \\
" $NOVA_CONF

exit 0
