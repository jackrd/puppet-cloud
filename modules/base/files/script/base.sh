#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

source /tmp/env/setuprc.sh

#####################################################################################
# Configuration File
NTP_CONF=/etc/ntp.conf
MYSQL_CONF=/etc/mysql/my.cnf
IFACES_CONF=/etc/network/interfaces
HOSTS_CONF=/etc/hosts

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
sed -i '/^bind-address/s/127.0.0.1/0.0.0.0/g' $MYSQL_CONF
	
# Setup mysql to support utf8 and innodb
sed -i "/default-storage-engine/d" $MYSQL_CONF
sed -i "/innodb_file_per_table/d" $MYSQL_CONF
sed -i "/collation-server = utf8_general_ci/d" $MYSQL_CONF
sed -i "/init-connect/d" $MYSQL_CONF
sed -i "/character-set-server/d" $MYSQL_CONF

sed -i "/\[mysqld\]/a \\
default-storage-engine = innodb \\
innodb_file_per_table \\
collation-server = utf8_general_ci \\
init-connect = 'SET NAMES utf8' \\
character-set-server = utf8 \\
" $MYSQL_CONF

##rabbitmqctl change_password guest RABBIT_PASS

#####################################################################################
# Edit the /etc/network/interfaces 
sed -i "/auto/d" $IFACES_CONF
sed -i "/iface/d" $IFACES_CONF
sed -i "/address/d" $IFACES_CONF
sed -i "/netmask/d" $IFACES_CONF
sed -i "/gateway/d" $IFACES_CONF

# loopback interface
sed -i "1 i\auto lo \\
iface lo inet loopback \
" $IFACES_CONF

# management interface
sed -i "1 i\auto $NIC_DEV_NAME_01 \\
iface $NIC_DEV_NAME_01 inet static \\
address $MGMT_NETIP_CONTROLLER \\
netmask $MGMT_NETMASK \\
#gateway $MGMT_GATEWAY \
" $IFACES_CONF

# external interface
sed -i "1 i\auto $NIC_DEV_NAME_02 \\
iface $NIC_DEV_NAME_02 inet dhcp \
" $IFACES_CONF

#####################################################################################
# Edit the /etc/hosts 

sed -i "/controller/d" $HOSTS_CONF
sed -i "/network/d" $HOSTS_CONF
sed -i "/compute1/d" $HOSTS_CONF
sed -i "/block1/d" $HOSTS_CONF
sed -i "/object1/d" $HOSTS_CONF

# controller 
sed -i "1 i\$MGMT_NETIP_CONTROLLER      controller"  $HOSTS_CONF

# network 
sed -i "1 i\$MGMT_NETIP_NETWORK      network"  $HOSTS_CONF

# compute1 
sed -i "1 i\$MGMT_NETIP_COMPUTE1      compute1"  $HOSTS_CONF

# block1 
sed -i "1 i\$MGMT_NETIP_BLOCK1      block1"  $HOSTS_CONF

# object1 
sed -i "1 i\$MGMT_NETIP_OBJECT1      object1"  $HOSTS_CONFex

exit 0
