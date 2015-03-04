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

	include base
	
	$username = 'root'
	$passwd = '111111'

	$db_name = 'keystone'
	$db_passwd = '222222'
	
	#include test

	$tenantName = 'admin'
	$tenantDesc = 'tenant Desc'
	$userName = 'admin'
	$userpwd = 'admin_pass'
	$userEmail = 'xxx@xxx.xxx'
	$roleName = 'admin'
	$serviceName = 'keystone'
	$serviceType = 'identity'
	$serviceDesc = 'service Desc'
	
	$keystone_db_name = 'keystone'
	$keystone_db_passwd = '222222'
	$kEYSTONE_DBPASS = 'KEYSTONE_DBPASS'

	include keystone

	$gLANCE_DBPASS = 'GLANCE_DBPASS'
	$gLANCE_PASS = 'GLANCE_PASS'
		
	$glance_db_name = 'glance'
	$glance_db_passwd = '222222'

	include glance


	$nOVA_DBPASS = 'NOVA_DBPASS'
	$nOVA_PASS = 'NOVA_PASS'
	$nOVA_EMAIL = 'NOVA_EMAIL'

	include nova
	$nEUTRON_DBPASS = 'NEUTRON_DBPASS'
	$nEUTRON_PASS = 'NEUTRON_PASS'
	$nEUTRON_EMAIL = 'NEUTRON_EMAIL'
	$mETADATA_SECRET = 'METADA_SECRET'
	include neutron
	include horizon


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

	$nOVA_DBPASS = 'NOVA_DBPASS'
	$nOVA_PASS = 'NOVA_PASS'
	$nOVA_EMAIL = 'NOVA_EMAIL'
	include nova

	$nEUTRON_DBPASS = 'NEUTRON_DBPASS'
	$nEUTRON_PASS = 'NEUTRON_PASS'
	$nEUTRON_EMAIL = 'NEUTRON_EMAIL'
	$mETADATA_SECRET = 'METADA_SECRET'
	$iNTERFACE_NAME = 'em3'
	include neutron
	

	

}

