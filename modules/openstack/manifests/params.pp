class openstack::params {

	$nodetype = ''
	$mGMT_NETIP_CONTROLLER = '192.168.0.11'
	$mGMT_NETIP_NETWORK = '192.168.0.21'
	$mGMT_NETIP_COMPUTE1 = '192.168.0.14'
	$mGMT_NETMASK = '255.255.255.0'
	$mGMT_GATEWAY = '192.168.0.1'
	$iNST_TUNIP_NETWORK = '192.168.1.12'
	$iNST_TUNIP_COMPUTE1 = '192.168.1.13'
	$nIC_DEV_NAME_01 = 'em1'
	$nIC_DEV_NAME_02 = 'em2'
	$nIC_DEV_NAME_03 = 'em3'
	$nIC_DEV_NAME_04 = 'em4'
	$rABBIT_HOST = 'cntrnode'
	$rABBIT_PASS = 'RABBIT_PASS'
	$aDMIN_PASS = 'ADMIN_PASS'
	$aDMIN_EMAIL = 'ADMIN_EMAIL'
	$aDMIN_TOKEN = 'ADMIN_TOKEN'
	$aUTH_HOST = 'cntrnode'
	$db_username = 'root'
	$db_passwd = '111111'
	$kEYSTONE_DBPASS = '111111'
	$keystone_db_name = 'keystone'
	$keystone_db_passwd = '111111'
	$oS_USERNAME = 'admin'
 	$oS_PASSWORD = 'ADMIN_PASS'
 	$oS_TENANT_NAME = 'admin'
	$oS_AUTH_URL = 'http://cntrnode:35357/v2.0'
	$os_service_token = 'ADMIN_TOKEN'
	$os_service_endpoint = 'http://cntrnode:35357/v2.0'
	$gLANCE_DBPASS = '111111'
	$gLANCE_PASS = '111111'
	$gLANCE_EMAIL = 'GLANCE_EMAIL'
	$glance_db_name = 'glance'
	$glance_db_passwd = '111111'
	$nOVA_DBPASS = '111111'
	$nOVA_PASS = '111111'
	$nOVA_EMAIL = 'NOVA_EMAIL'
	$nova_db_name = 'nova'
	$nova_db_passwd = '111111'
	$nEUTRON_PASS = '111111'
	$nEUTRON_DBPASS = '111111'		
	$nEUTRON_EMAIL = 'NEUTRON_EMAIL'
	$neutron_db_name = 'neutron'
	$neutron_db_passwd = '111111'
	$mETADATA_SECRET = 'METADA_SECRET'
	$iNTERFACE_NAME = 'em3'
	$fLOATING_IP_START = '192.168.1.101'
	$fLOATING_IP_END = '192.168.1.200'
	$eXTERNAL_NETWORK_GATEWAY = '192.168.1.1' 
	$eXTERNAL_NETWORK_CIDR ='192.168.1.0/24'
	$tENANT_NETWORK_GATEWAY = '192.168.3.1' 
	$tENANT_NETWORK_CIDR = '192.168.3.0/24'

}