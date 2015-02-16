#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

#####################################################################################
# Source the setup file to read in the environment variables

source /tmp/env/setuprc.sh

# Configuration File
NOVA_CONF=/etc/nova/nova.conf
NOVA_COMPUTE_CONF=/etc/nova/nova-compute.conf

#####################################################################################
# 2. To make the current kernel readable
# For security reasons, the Linux kernel is not readable by normal users
# which restricts hypervisor services such as qemu and libguestfs
dpkg-statoverride  --update --add root root 0644 /boot/vmlinuz-$(uname -r)

# To also enable this override for all future kernel updates
#echo "
##!/bin/sh
#version="$1"
## passing the kernel version is required
#[ -z \"${version}\" ] && exit 0
#dpkg-statoverride --update --add root root 0644 /boot/vmlinuz-${version}
#" > /etc/kernel/postinst.d/statoverride

#####################################################################################
# Edit the /etc/nova/nova.conf configuration file
sed -i "/^auth_strategy/d" $NOVA_CONF

sed -i "/^\[DEFAULT\]/a \\
auth_strategy = keystone
" $NOVA_CONF

sed -i "/^connection/d" $NOVA_CONF

sed -i "/^\[database\]/a \\
connection = mysql:\/\/nova:$NOVA_DBPASS@$MGMT_NETIP_CONTROLLER/nova
" $NOVA_CONF

sed -i "/^auth_uri/d" $NOVA_CONF
sed -i "/^auth_host/d" $NOVA_CONF
sed -i "/^auth_port/d" $NOVA_CONF
sed -i "/^auth_protocol/d" $NOVA_CONF
sed -i "/^admin_tenant_name/d" $NOVA_CONF
sed -i "/^admin_user/d" $NOVA_CONF
sed -i "/^admin_password/d" $NOVA_CONF

sed -i "/^\[keystone_authtoken\]/a \\
auth_uri = http://$MGMT_NETIP_CONTROLLER:5000 \\
auth_host = controller \\
auth_port = 35357 \\
auth_protocol = http \\
admin_tenant_name = service \\
admin_user = nova \\
admin_password = $NOVA_ADMIN_PASSWORD
" $NOVA_CONF

# Configure the Compute service to use the RabbitMQ message broker
sed -i "/^rpc_backend/d" $NOVA_CONF
sed -i "/^rabbit_host/d" $NOVA_CONF
sed -i "/^rabbit_password/d" $NOVA_CONF

sed -i "/^\[DEFAULT\]/a \\
rpc_backend = rabbit \\
rabbit_host = controller \\
rabbit_password = RABBIT_PASS \\
" $NOVA_CONF

# Configure Compute to provide remote console access to instances
EXT_IP=$(ifconfig $NIC_DEV_NAME_02| sed -n 's/.*inet *addr:\([0-9\.]*\).*/\1/p')

sed -i "/^vnc_enabled/d" $NOVA_CONF
sed -i "/^novncproxy_base_url/d" $NOVA_CONF
sed -i "/^my_ip/d" $NOVA_CONF
sed -i "/^vncserver_listen/d" $NOVA_CONF
sed -i "/^vncserver_proxyclient_address/d" $NOVA_CONF

sed -i "/\[DEFAULT\]/a \\
my_ip = $MGMT_NETIP_COMPUTE1 \\
vnc_enabled = True \\
vncserver_listen = 0.0.0.0 \\
vncserver_proxyclient_address = $MGMT_NETIP_COMPUTE1 \\
novncproxy_base_url = http://$EXT_IP:6080/vnc_auto.html \\
" $NOVA_CONF


# Specify the host that runs the Image Service
sed -i "/^glance_host/d" $NOVA_CONF

sed -i "/^\[DEFAULT\]/a \\
glance_host = controller \\
" $NOVA_CONF

# You must determine whether your system's processor and/or hypervisor
# support hardware acceleration for virtual machines
HW_ACCELERATION_VALUE=$(egrep -c '(vmx|svm)' /proc/cpuinfo)

if [ "$HW_ACCELERATION_VALUE" == "0" ]
then
	sed -i "/^virt_type/d" $NOVA_COMPUTE_CONF

	sed -i "/^\[libvirt\]/a \\
	virt_type = qemu
	" $NOVA_COMPUTE_CONF
fi

# Remove the SQLite database created by the packages
rm -f /var/lib/nova/nova.sqlite

exit 0