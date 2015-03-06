#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash


#####################################################################################
# Source the setup file to read in the environment variables

source /tmp/env/setuprc.sh
source /tmp/horizon/env/horizonrc.sh

#####################################################################################

HORIZON_CONF=/etc/openstack-dashboard/local_settings.py
APACHE2_CONF=/etc/apache2/apache2.conf

sed -i '/^#/d' $HORIZON_CONF
sed -i '/^\s*$/d' $HORIZON_CONF

sed -i '/^#/d' $APACHE2_CONF
sed -i '/^\s*$/d' $APACHE2_CONF

#####################################################################################
# Modify the value of CACHES['default']['LOCATION'] in
# /etc/openstack-dashboard/local_settings.py to match the ones set in /etc/memcached.conf
# Update the ALLOWED_HOSTS in local_settings.py to include
# the addresses you wish to access the dashboard from
# Grab our IP

EXT_IP=$(/sbin/ifconfig $NIC_DEV_NAME_02| sed -n 's/.*inet *addr:\([0-9\.]*\).*/\1/p')

sed -i "/^ALLOWED_HOSTS/d" $HORIZON_CONF
sed -i "/^OPENSTACK_HOST/d" $HORIZON_CONF

sed -i "1 i\ALLOWED_HOSTS = ['*']
" $HORIZON_CONF

sed -i "1 i\OPENSTACK_HOST = \"$EXT_IP\" 
" $HORIZON_CONF

sed -i "/^ServerName/d" $APACHE2_CONF

sed -i "\$a \\
ServerName localhost
" $APACHE2_CONF

exit 0