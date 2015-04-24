#!/bin/bash

PV_Dev_Array=( "$@" )

source /tmp/env/setuprc.sh

LVM_CONF=/etc/lvm/lvm.conf
CINDER_CONF=/etc/cinder/cinder.conf 
HOSTS_CONF=/etc/hosts

sed -i '/^#/d' $LVM_CONF
sed -i '/^\s*$/d' $LVM_CONF

sed -i '/^#/d' $CINDER_CONF
sed -i '/^\s*$/d' $CINDER_CONF

#edit /etc/hosts
sed -i "1 i $MGMT_NETIP_BLOCK      ${BLK_HOSTNAME}.iec.inventec ${BLK_HOSTNAME}"  $HOSTS_CONF

#create LVM
for ((i = 1; i < ${#PV_Dev_Array[@]}; i++))
do
    PV_Dev=${PV_Dev_Array[$i]}
	
	pvcreate /dev/$PV_Dev
    vgcreate cinder-volumes /dev/$PV_Dev
done

#get below two directly from hiera 
#openstack::os_partition:'\"a\/sda1\/\"'
#openstack::block_devs: ' \"a\/sdb\/\", \"a\/sdc\/\" '
#OS_PARTITION=\"a\/sda1\/\"
#BLOCK_DEVS=\"a\/sdb\/\"

OS_PARTITION+=\\\"a\\\/${PV_Dev_Array[0]}\\\/\\\"

for ((i = 1; i < ${#PV_Dev_Array[@]}; i++))
do
    PV_Dev=${PV_Dev_Array[$i]}
	if [ $i -eq 1 ];then
		BLOCK_DEVS+=\'
	fi
	
	BLOCK_DEVS+=\\\"a\\\/$PV_Dev\\\/\\\"
	
	if [ $i -le $(( ${#PV_Dev_Array[@]}-2 )) ];then
		BLOCK_DEVS+=,
	fi
done
	BLOCK_DEVS+=\'

sed -i "
/^    filter =.*$/s/^.*$/    filter = [ $OS_PARTITION , $BLOCK_DEVS, \"r\/.*\/\"\]/
" $LVM_CONF


sed -i "/\[keystone_authtoken\]/a \\
auth_uri = http://$MGMT_NETIP_CONTROLLER:5000 \\
auth_host = cntrnode \\
auth_port = 35357 \\
auth_protocol = http \\
admin_tenant_name = service \\
admin_user = cinder \\
admin_password = $CINDER_PASS
" $CINDER_CONF

sed -i "/\[DEFAULT\]/a \\
rpc_backend = rabbit \\
rabbit_host = cntrnode \\
rabbit_port = 5672 \\
rabbit_userid = guest \\
rabbit_password = $RABBIT_PASS \\
" $CINDER_CONF

sed -i "/\[database\]/a \\
connection = mysql:\/\/cinder:$CINDER_DBPASS@$MGMT_NETIP_CONTROLLER/cinder
" $CINDER_CONF

sed -i "/\[DEFAULT\]/a \\
my_ip = $MGMT_NETIP_BLOCK1 \\
" $CINDER_CONF

sed -i "/\[DEFAULT\]/a \\
glance_host = cntrnode \\
" $CINDER_CONF

exit 0
