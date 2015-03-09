node 'puppet.iec.inventec' {
 file { '/tmp/hello':
                content => "Hello\n",
        }

}

node 'cntrnode.iec.inventec' {

	$var = '999'
	$var2 = '7777'
	$var3 = '77'
	
	$mGMT_NETIP_CONTROLLER = '192.168.0.11'
	$mGMT_NETIP_NETWORK = '192.168.0.21'
	$mGMT_NETIP_COMPUTE1 = '192.168.0.14'
	#$mgmtip_block1 = '192.168.0.14'
	#$mgmtip_object1 = '192.168.0.15'

	$mGMT_NETMASK = '255.255.255.0'
	$mGMT_GATEWAY = '192.168.0.1'

	$iNST_TUNIP_NETWORK = '192.168.1.12'
	$iNST_TUNIP_COMPUTE1 = '192.168.1.13'

	$nIC_DEV_NAME_01 = 'em1'
	$nIC_DEV_NAME_02 = 'em2'
	$nIC_DEV_NAME_03 = 'em3'
	$nIC_DEV_NAME_04 = 'em4'

	$nodetype = 'cntrnode'

	$rABBIT_HOST = 'cntrnode'
	$rABBIT_PASS = 'RABBIT_PASS'

	$aDMIN_PASS = 'ADMIN_PASS'
	$aDMIN_EMAIL = 'ADMIN_EMAIL'
	$aDMIN_TOKEN = 'ADMIN_TOKEN'
	
	$aUTH_HOST = 'cntrnode'

	$db_passwd = '111111'

	include base
	
	$tenantName = 'admin'
	$tenantDesc = 'tenant Desc'
	$userName = 'admin'
	$userpwd = 'admin_pass'
	$userEmail = 'xxx@xxx.xxx'
	$roleName = 'admin'
	$serviceName = 'keystone'
	$serviceType = 'identity'
	$serviceDesc = 'service Desc'
	
	$kEYSTONE_DBPASS = '111111'
	$kEYSTONE_PASS = '111111'
	$keystone_db_name = 'keystone'
	$keystone_db_passwd = '111111'

	include keystone

	$gLANCE_DBPASS = '222222'
	$gLANCE_PASS = '111111'
		
	$glance_db_name = 'glance'
	$glance_db_passwd = '222222'

	include glance

	$nOVA_DBPASS = '222222'
	$nOVA_PASS = '111111'
	$nOVA_EMAIL = 'NOVA_EMAIL'
	
	$nova_db_name = 'nova'
	$nova_db_passwd = '222222'

	include nova

	$nEUTRON_ADMIN_PASSWORD = '111111'
	$nEUTRON_DBPASS = 'NEUTRON_DBPASS'
	$nEUTRON_PASS = '111111'
	$nEUTRON_EMAIL = 'NEUTRON_EMAIL'
		
	$neutron_db_name = 'neutron'
	$neutron_db_passwd = 'NEUTRON_DBPASS'

	$mETADATA_SECRET = 'METADA_SECRET'
	$iNTERFACE_NAME = 'em3'

	include neutron

	include horizon

	#include test

}

node 'networknode.iec.inventec' {
	$var_1 = '999'
	$var2 = '7777'
	$var3 = '77'
	#include test

	
	$mGMT_NETIP_CONTROLLER = '192.168.0.11'
	$mGMT_NETIP_NETWORK = '192.168.0.21'
	$mGMT_NETIP_COMPUTE1 = '192.168.0.14'
	#$mgmtip_block1 = '192.168.0.14'
	#$mgmtip_object1 = '192.168.0.15'

	$mGMT_NETMASK = '255.255.255.0'
	$mGMT_GATEWAY = '192.168.0.1'

	$iNST_TUNIP_NETWORK = '192.168.1.12'
	$iNST_TUNIP_COMPUTE1 = '192.168.1.13'

	$nIC_DEV_NAME_01 = 'em1'
	$nIC_DEV_NAME_02 = 'em2'
	$nIC_DEV_NAME_03 = 'em3'
	$nIC_DEV_NAME_04 = 'em4'

	$node_type = 'networknode'
	$rabbitpwd = 'RABBIT_PASS'
	$nodetype = 'networknode'
	$rABBIT_HOST = 'cntrnode'
	$rABBIT_PASS = 'RABBIT_PASS'

	$aDMIN_PASS = 'ADMIN_PASS'
	$aDMIN_EMAIL = 'ADMIN_EMAIL'
	$aDMIN_TOKEN = 'ADMIN_TOKEN'
	
	$aUTH_HOST = 'cntrnode'

	include base

	$nEUTRON_ADMIN_PASSWORD = '111111'
	$nEUTRON_DBPASS = 'NEUTRON_DBPASS'
	$nEUTRON_PASS = 'NEUTRON_PASS'
	$nEUTRON_EMAIL = 'NEUTRON_EMAIL'
	$mETADATA_SECRET = 'METADA_SECRET'
	$iNTERFACE_NAME = 'em3'

	include neutron


}

node 'comptnode.iec.inventec' {
	$var = '999'
	$var2 = '7777'
	$var3 = '77'
	#include test
	
	$mGMT_NETIP_CONTROLLER = '192.168.0.11'
	$mGMT_NETIP_NETWORK = '192.168.0.21'
	$mGMT_NETIP_COMPUTE1 = '192.168.0.14'
	#$mgmtip_block1 = '192.168.0.14'
	#$mgmtip_object1 = '192.168.0.15'

	$mGMT_NETMASK = '255.255.255.0'
	$mGMT_GATEWAY = '192.168.0.1'

	$iNST_TUNIP_NETWORK = '192.168.1.12'
	$iNST_TUNIP_COMPUTE1 = '192.168.1.13'

	$nIC_DEV_NAME_01 = 'em1'
	$nIC_DEV_NAME_02 = 'em2'
	$nIC_DEV_NAME_03 = 'em3'
	$nIC_DEV_NAME_04 = 'em4'


	$rabbitpwd = 'RABBIT_PASS'
	$nodetype = 'comptnode'
	$rABBIT_HOST = 'cntrnode'
	$rABBIT_PASS = 'RABBIT_PASS'

	$aDMIN_PASS = 'ADMIN_PASS'
	$aDMIN_EMAIL = 'ADMIN_EMAIL'
	$aDMIN_TOKEN = 'ADMIN_TOKEN'

	$aUTH_HOST = 'cntrnode'

	include base

	$nOVA_DBPASS = '222222'
	$nOVA_PASS = '111111'
	$nOVA_EMAIL = 'NOVA_EMAIL'

	include nova

	$nEUTRON_ADMIN_PASSWORD = '111111'
	$nEUTRON_DBPASS = 'NEUTRON_DBPASS'
	$nEUTRON_PASS = 'NEUTRON_PASS'
	$nEUTRON_EMAIL = 'NEUTRON_EMAIL'
	$mETADATA_SECRET = 'METADA_SECRET'
	$iNTERFACE_NAME = 'em3'

	include neutron
	

	

}

