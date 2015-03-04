#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash


#####################################################################################
# Source the setup file to read in the environment variables

source /tmp/env/setuprc.sh
source /tmp/neutron/env/neutronrc.sh
source /tmp/nova/env/novarc.sh

# Configuration File
NEUTRON_CONF=/etc/neutron/neutron.conf
NOVA_CONF=/etc/nova/nova.conf
ML2_CONF=/etc/neutron/plugins/ml2/ml2_conf.ini


# To configure the Networking server component
# Configure Networking to use the database
sed -i "/^connection/d" $NEUTRON_CONF

sed -i "
/^\[database\]/a connection = mysql:\/\/neutron:$NEUTRON_DBPASS@$MGMT_NETIP_CONTROLLER\/neutron
" $NEUTRON_CONF

# Configure Networking to use the Identity service for authentication
sed -i "/^auth_strategy/d" $NEUTRON_CONF

sed -i "
/^\[DEFAULT\]/a \\
auth_strategy = keystone
" $NEUTRON_CONF

sed -i "/^auth_uri/d" $NEUTRON_CONF
sed -i "/^auth_host/d" $NEUTRON_CONF
sed -i "/^admin_tenant_name/d" $NEUTRON_CONF
sed -i "/^admin_user/d" $NEUTRON_CONF
sed -i "/^admin_password/d" $NEUTRON_CONF

sed -i "/^\[keystone_authtoken\]/a \\
auth_uri = http:\/\/$MGMT_NETIP_CONTROLLER:5000 \\
auth_host = $AUTH_HOST \\
admin_tenant_name = service \\
admin_user = neutron \\
admin_password = $NEUTRON_PASS \\
" $NEUTRON_CONF

# Configure Networking to use the message broker
sed -i "/^rpc_backend/d" $NEUTRON_CONF
sed -i "/^rabbit_host/d" $NEUTRON_CONF
sed -i "/^rabbit_password/d" $NEUTRON_CONF

sed -i "
/^\[database\]/a \\
rpc_backend = neutron.openstack.common.rpc.impl_kombu \\
rabbit_host = $RABBIT_HOST \\
rabbit_password = $RABBIT_PASS \\
" $NEUTRON_CONF


# Configure Networking to notify Compute about network topology changes
sed -i "/^notify_nova_on_port_status_changes/d" $NEUTRON_CONF
sed -i "/^notify_nova_on_port_data_changes/d" $NEUTRON_CONF
sed -i "/^nova_url/d" $NEUTRON_CONF
sed -i "/^nova_admin_username/d" $NEUTRON_CONF
sed -i "/^nova_admin_tenant_id/d" $NEUTRON_CONF
sed -i "/^nova_admin_password/d" $NEUTRON_CONF
sed -i "/^nova_admin_auth_url/d" $NEUTRON_CONF

SERVICE_TENANT_ID=$(keystone tenant-get service | awk '/ id / {print $4}')

sed -i "/^\[DEFAULT\]/a \\
notify_nova_on_port_status_changes = True \\
notify_nova_on_port_data_changes = True \\
nova_url = http:\/\/$MGMT_NETIP_CONTROLLER:8774\/v2  \\
nova_admin_username = nova \\
nova_admin_tenant_id = $SERVICE_TENANT_ID \\
nova_admin_password = $NOVA_PASS \\
nova_admin_auth_url = http:\/\/$MGMT_NETIP_CONTROLLER:35357\/v2.0 \\
" $NEUTRON_CONF

sed -i "/^core_plugin/d" $NEUTRON_CONF
sed -i "/^service_plugins/d" $NEUTRON_CONF
sed -i "/^allow_overlapping_ips/d" $NEUTRON_CONF

# Configure Networking to use the Modular Layer 2 (ML2) plug-in and associated services
sed -i "/^\[DEFAULT\]/a \\
core_plugin = ml2 \\
service_plugins = router \\
allow_overlapping_ips = True \\
" $NEUTRON_CONF

#####################################################################################
# To configure the Modular Layer 2 (ML2) plug-in
# The ML2 plug-in uses the Open vSwitch (OVS) mechanism (agent)
# to build the virtual networking framework for instances

sed -i "/^type_drivers/d" $ML2_CONF
sed -i "/^tenant_network_types/d" $ML2_CONF
sed -i "/^mechanism_drivers/d" $ML2_CONF
sed -i "/^tunnel_id_ranges/d" $ML2_CONF
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

sed -i "/^\[securitygroup\]/a \\
firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver \\
enable_security_group = True \\
" $ML2_CONF

#####################################################################################
# To configure Compute to use Networking
# Most distributions configure Compute to use legacy networking.
# You must reconfigure Compute to manage networks through Networking

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
neutron_admin_password = $NEUTRON_PASS \\
neutron_admin_auth_url = http://$MGMT_NETIP_CONTROLLER:35357/v2.0 \\
linuxnet_interface_driver = nova.network.linux_net.LinuxOVSInterfaceDriver \\
firewall_driver = nova.virt.firewall.NoopFirewallDriver \\
security_group_api = neutron
" $NOVA_CONF

#####################################################################################
# To configure the metadata agent
# On the controller node, edit the /etc/nova/nova.conf file
sed -i "/^service_neutron_metadata_proxy/d" $NOVA_CONF
sed -i "/^neutron_metadata_proxy_shared_secret/d" $NOVA_CONF

sed -i "/^\[DEFAULT\]/a \\
service_neutron_metadata_proxy = true \\
neutron_metadata_proxy_shared_secret = $METADATA_SECRET \\
" $NOVA_CONF

exit 0