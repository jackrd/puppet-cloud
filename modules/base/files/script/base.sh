#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

source /tmp/env/setuprc.sh
node_type=$1

if [ "$node_type" == "comptnode" ]
then
	ip_address=$MGMT_NETIP_COMPUTE1
	ip_address2=$INST_TUNIP_COMPUTE1
elif [ "$node_type" == "networknode" ]
then
	ip_address=$MGMT_NETIP_NETWORK
	ip_address2=$INST_TUNIP_NETWORK
else
	ip_address=$MGMT_NETIP_CONTROLLER
fi	

#####################################################################################
# Configuration File

NTP_CONF=/etc/ntp.conf
MYSQL_CONF=/etc/mysql/my.cnf
IFACES_CONF=/etc/network/interfaces
HOSTS_CONF=/etc/hosts

sed -i "/^#/d" $NTP_CONF
sed -i "/^#/d" $MYSQL_CONF
sed -i "/^#/d" $IFACES_CONF
sed -i "/^#/d" $HOSTS_CONF


sed -i '/^\s*$/d' $NTP_CONF
sed -i '/^\s*$/d' $MYSQL_CONF
#sed -i '/^\s*$/d' $IFACES_CONF
sed -i '/^\s*$/d' $HOSTS_CONF


#####################################################################################
# Edit the/etc/ntp.conf

sed -i "/server 127.127.1.0/d" $NTP_CONF
sed -i "/fudge 127.127.1.0 stratum 10/d" $NTP_CONF

sed -i "/ntp.ubuntu.com/a \\
server 127.127.1.0 \\
fudge 127.127.1.0 stratum 10 \\
" $NTP_CONF

#####################################################################################
# Edit the /etc/mysql/my.cnf 

if [ "$node_type" == "cntrnode" ]
then
	
# Setup mysql to support utf8 and innodb
sed -i "/^bind-address/d" $MYSQL_CONF
sed -i "/^default-storage-engine/d" $MYSQL_CONF
sed -i "/^innodb_file_per_table/d" $MYSQL_CONF
sed -i "/^collation-server = utf8_general_ci/d" $MYSQL_CONF
sed -i "/^init-connect/d" $MYSQL_CONF
sed -i "/^character-set-server/d" $MYSQL_CONF

sed -i "/\[mysqld\]/a \\
default-storage-engine = innodb \\
innodb_file_per_table \\
collation-server = utf8_general_ci \\
init-connect = 'SET NAMES utf8' \\
character-set-server = utf8 \\
bind-address = 0.0.0.0 \\
" $MYSQL_CONF
rabbitmqctl change_password guest $RABBIT_PASS
fi

#####################################################################################
# Edit the /etc/network/interfaces 

sed -i "/^auto/d" $IFACES_CONF
sed -i "/^iface/d" $IFACES_CONF
sed -i "/^address/d" $IFACES_CONF
sed -i "/^netmask/d" $IFACES_CONF
sed -i "/^gateway/d" $IFACES_CONF
echo " " >> $IFACES_CONF


# loopback interface
sed -i "1 i\auto lo \\
iface lo inet loopback \\
" $IFACES_CONF

# management interface
sed -i "1 i\auto $NIC_DEV_NAME_01 \\
iface $NIC_DEV_NAME_01 inet static \\
address $ip_address \\
netmask $MGMT_NETMASK \\
#gateway $MGMT_GATEWAY \\
" $IFACES_CONF

if [ "$node_type" == "comptnode" ] || [ "$node_type" == "networknode" ]
then
# tunnel interface
sed -i "1 i\auto $NIC_DEV_NAME_02 \\
iface $NIC_DEV_NAME_02 inet static \\
address $ip_address2 \\
netmask $MGMT_NETMASK \\
" $IFACES_CONF
fi

if [ "$node_type" == "networknode" ]
then
# external interface
sed -i "1 i\auto $NIC_DEV_NAME_03 \\
iface $NIC_DEV_NAME_03 inet manual \\
up ip link set $NIC_DEV_NAME_03 promisc on \\
" $IFACES_CONF

# external bridge
sed -i "1 i\auto br-ex \\
iface br-ex inet dhcp \\
" $IFACES_CONF
fi

#####################################################################################
# Edit the /etc/hosts 

sed -i "/cntrnode/d" $HOSTS_CONF
sed -i "/networknode/d" $HOSTS_CONF
sed -i "/comptnode/d" $HOSTS_CONF
sed -i "/block1/d" $HOSTS_CONF
sed -i "/object1/d" $HOSTS_CONF

# controller 
sed -i "1 i $MGMT_NETIP_CONTROLLER      cntrnode.iec.inventec cntrnode"  $HOSTS_CONF

# network 
sed -i "1 i $MGMT_NETIP_NETWORK      networknode.iec.inventec networknode"  $HOSTS_CONF

# compute1 
sed -i "1 i $MGMT_NETIP_COMPUTE1      comptnode.iec.inventec comptnode"  $HOSTS_CONF

# block1 
#sed -i "1 i $MGMT_NETIP_BLOCK1      block1"  $HOSTS_CONF

# object1 
#sed -i "1 i $MGMT_NETIP_OBJECT1      object1"  $HOSTS_CONFex

exit 0
