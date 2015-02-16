#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash


#####################################################################################
# Source the setup file to read in the environment variables
source /tmp/env/setuprc.sh

# Configuration File
LVM_CONF=/etc/lvm/lvm.conf
CINDER_CONF=/etc/cinder/cinder.conf

#####################################################################################
# Configure a Block Storage service node
# Create the LVM physical and logical volumes
#echo;
#read -p "Enter the device that is used for pvcreate (ex: sdb or sdc)" PV_Dev
# Note: If found "Device not found or ignored by filtering", please erase the partition table
# by running "dd if=/dev/zero of=/dev/sdb bs=512 count=1" before create the physical volume
#for ((i = 0; i < ${#PV_Dev_Array[@]}; i++))
#do
#    PV_Dev=${PV_Dev_Array[$i]}
#	
#	pvcreate /dev/$PV_Dev
#    vgcreate cinder-volumes /dev/$PV_Dev
#done


# 4. Add a filter entry to the devices section in the /etc/lvm/lvm.conf file
# to keep LVM from scanning devices used by virtual machines

sed -i "/^filter/d"  $LVM_CONF
sed -i "
filter = [ \"a\/sda1\/\", \"a\/sdb\/\", \"r\/.*\/\"\]/
" $LVM_CONF

# Note: The physical volumes that are required on the Block Storage host have names
# that begin with a. The array must end with " r/.*/ " to reject any device not listed

# 5. After you configure the operating system,
# install the appropriate packages for the Block Storage service
# 6. Edit the /etc/cinder/cinder.conf configuration file and 
# add this section for keystone credentials

sed -i "/^auth_uri/d" $CINDER_CONF
sed -i "/^auth_host/d" $CINDER_CONF
sed -i "/^auth_port/d" $CINDER_CONF
sed -i "/^auth_protocol/d" $CINDER_CONF
sed -i "/^admin_tenant_name/d" $CINDER_CONF
sed -i "/^admin_user/d" $CINDER_CONF
sed -i "/^admin_password/d" $CINDER_CONF


sed -i "/^\[keystone_authtoken\]/a \\
auth_uri = http://$MGMT_NETIP_CONTROLLER:5000 \\
auth_host = controller \\
auth_port = 35357 \\
auth_protocol = http \\
admin_tenant_name = service \\
admin_user = cinder \\
admin_password = $CINDER_ADMIN_PASSWORD
" $CINDER_CONF

sed -i "/^rpc_backend/d" $CINDER_CONF
sed -i "/^rabbit_host/d" $CINDER_CONF
sed -i "/^rabbit_port/d" $CINDER_CONF
sed -i "/^rabbit_userid/d" $CINDER_CONF
sed -i "/^rabbit_password/d" $CINDER_CONF
sed -i "/^my_ip/d" $CINDER_CONF
sed -i "/^glance_host/d" $CINDER_CONF

# 7. Configure Block Storage to use the RabbitMQ message broker
sed -i "/^\[DEFAULT\]/a \\
rpc_backend = rabbit \\
rabbit_host = controller \\
rabbit_port = 5672 \\
rabbit_userid = guest \\
rabbit_password = RABBIT_PASS \\
my_ip = $MGMT_NETIP_BLOCK1 \\
glance_host = controller \\
" $CINDER_CONF

# 8. Configure Block Storage to use your MySQL database
sed -i "/^\[database\]/a \\
connection = mysql:\/\/cinder:$CINDER_DBPASS@$MGMT_NETIP_CONTROLLER/cinder
" $CINDER_CONF

exit 0