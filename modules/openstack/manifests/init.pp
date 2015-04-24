class openstack (
        $mGMT_NETIP_CONTROLLER  =  hiera('$openstack::mGMT_NETIP_CONTROLLER', $openstack::params::mGMT_NETIP_CONTROLLER),
        $mGMT_NETIP_NETWORK  =  hiera('$openstack::mGMT_NETIP_NETWORK', $openstack::params::mGMT_NETIP_NETWORK),
        $mGMT_NETIP_COMPUTE1  =  hiera('$openstack::mGMT_NETIP_COMPUTE1', $openstack::params::mGMT_NETIP_COMPUTE1),
        $mGMT_NETMASK  =  hiera('$openstack::mGMT_NETMASK', $openstack::params::mGMT_NETMASK),
        $mGMT_GATEWAY  =  hiera('$openstack::mGMT_GATEWAY', $openstack::params::mGMT_GATEWAY),
        $iNST_TUNIP_NETWORK  =  hiera('$openstack::iNST_TUNIP_NETWORK', $openstack::params::iNST_TUNIP_NETWORK),
        $iNST_TUNIP_COMPUTE1  =  hiera('$openstack::iNST_TUNIP_COMPUTE1', $openstack::params::iNST_TUNIP_COMPUTE1),
        $nIC_DEV_NAME_01  =  hiera('$openstack::nIC_DEV_NAME_01', $openstack::params::nIC_DEV_NAME_01),
        $nIC_DEV_NAME_02  =  hiera('$openstack::nIC_DEV_NAME_02', $openstack::params::nIC_DEV_NAME_02),
        $nIC_DEV_NAME_03  =  hiera('$openstack::nIC_DEV_NAME_03', $openstack::params::nIC_DEV_NAME_03),
        $nIC_DEV_NAME_04  =  hiera('$openstack::nIC_DEV_NAME_04', $openstack::params::nIC_DEV_NAME_04),
        $nodetype  =  hiera('$openstack::nodetype', $openstack::params::nodetype),
        $rABBIT_HOST  =  hiera('$openstack::rABBIT_HOST', $openstack::params::rABBIT_HOST),
        $rABBIT_PASS  =  hiera('$openstack::rABBIT_PASS', $openstack::params::rABBIT_PASS),
        $aDMIN_PASS  =  hiera('$openstack::aDMIN_PASS', $openstack::params::aDMIN_PASS),
        $aDMIN_EMAIL  =  hiera('$openstack::aDMIN_EMAIL', $openstack::params::aDMIN_EMAIL),
        $aDMIN_TOKEN  =  hiera('$openstack::aDMIN_TOKEN', $openstack::params::aDMIN_TOKEN),
        $aUTH_HOST  =  hiera('$openstack::aUTH_HOST', $openstack::params::aUTH_HOST),
        $db_username  =  hiera('$openstack::db_username', $openstack::params::db_username),
        $db_passwd  =  hiera('$openstack::db_passwd', $openstack::params::db_passwd),
        $kEYSTONE_DBPASS  =  hiera('$openstack::kEYSTONE_DBPASS', $openstack::params::kEYSTONE_DBPASS),
        $keystone_db_name  =  hiera('$openstack::keystone_db_name', $openstack::params::keystone_db_name),
        $keystone_db_passwd  =  hiera('$openstack::keystone_db_passwd', $openstack::params::keystone_db_passwd),
        $oS_USERNAME  =  hiera('$openstack::oS_USERNAME', $openstack::params::oS_USERNAME),
        $oS_PASSWORD  =  hiera('$openstack::oS_PASSWORD', $openstack::params::oS_PASSWORD),
        $oS_TENANT_NAME  =  hiera('$openstack::oS_TENANT_NAME', $openstack::params::oS_TENANT_NAME),
        $oS_AUTH_URL  =  hiera('$openstack::oS_AUTH_URL', $openstack::params::oS_AUTH_URL),
        $os_service_token  =  hiera('$openstack::os_service_token', $openstack::params::os_service_token),
        $os_service_endpoint  =  hiera('$openstack::os_service_endpoint', $openstack::params::os_service_endpoint),
        $gLANCE_DBPASS  =  hiera('$openstack::gLANCE_DBPASS', $openstack::params::gLANCE_DBPASS),
        $gLANCE_PASS  =  hiera('$openstack::gLANCE_PASS', $openstack::params::gLANCE_PASS),
        $gLANCE_EMAIL  =  hiera('$openstack::gLANCE_EMAIL', $openstack::params::gLANCE_EMAIL),
        $glance_db_name  =  hiera('$openstack::glance_db_name', $openstack::params::glance_db_name),
        $glance_db_passwd  =  hiera('$openstack::glance_db_passwd', $openstack::params::glance_db_passwd),
        $nOVA_DBPASS  =  hiera('$openstack::nOVA_DBPASS', $openstack::params::nOVA_DBPASS),
        $nOVA_PASS  =  hiera('$openstack::nOVA_PASS', $openstack::params::nOVA_PASS),
        $nOVA_EMAIL  =  hiera('$openstack::nOVA_EMAIL', $openstack::params::nOVA_EMAIL),
        $nova_db_name  =  hiera('$openstack::nova_db_name', $openstack::params::nova_db_name),
        $nova_db_passwd  =  hiera('$openstack::nova_db_passwd', $openstack::params::nova_db_passwd),
        $nEUTRON_PASS  =  hiera('$openstack::nEUTRON_PASS', $openstack::params::nEUTRON_PASS),
        $nEUTRON_DBPASS  =  hiera('$openstack::nEUTRON_DBPASS', $openstack::params::nEUTRON_DBPASS),
        $nEUTRON_EMAIL  =  hiera('$openstack::nEUTRON_EMAIL', $openstack::params::nEUTRON_EMAIL),
        $neutron_db_name  =  hiera('$openstack::neutron_db_name', $openstack::params::neutron_db_name),
        $neutron_db_passwd  =  hiera('$openstack::neutron_db_passwd', $openstack::params::neutron_db_passwd),
        $mETADATA_SECRET  =  hiera('$openstack::mETADATA_SECRET', $openstack::params::mETADATA_SECRET),
        $iNTERFACE_NAME  =  hiera('$openstack::iNTERFACE_NAME', $openstack::params::iNTERFACE_NAME),
        $fLOATING_IP_START  =  hiera('$openstack::fLOATING_IP_START', $openstack::params::fLOATING_IP_START),
        $fLOATING_IP_END  =  hiera('$openstack::fLOATING_IP_END', $openstack::params::fLOATING_IP_END),
        $eXTERNAL_NETWORK_GATEWAY  =  hiera('$openstack::eXTERNAL_NETWORK_GATEWAY', $openstack::params::eXTERNAL_NETWORK_GATEWAY),
        $eXTERNAL_NETWORK_CIDR  =  hiera('$openstack::eXTERNAL_NETWORK_CIDR', $openstack::params::eXTERNAL_NETWORK_CIDR),
        $tENANT_NETWORK_GATEWAY  =  hiera('$openstack::tENANT_NETWORK_GATEWAY', $openstack::params::tENANT_NETWORK_GATEWAY),
        $tENANT_NETWORK_CIDR  =  hiera('$openstack::tENANT_NETWORK_CIDR', $openstack::params::tENANT_NETWORK_CIDR),
		$block_devices  =  hiera('$openstack::block_devices', $openstack::params::block_devices),
		$os_partition  =  hiera('$openstack::os_partition', $openstack::params::os_partition),
		$block_hostname  =  hiera('$openstack::block_hostname', $openstack::params::block_hostname),
		$numofblocknode  =  hiera('$openstack::numofblocknode', $openstack::params::numofblocknode),
) inherits openstack::params{

	notify { "The value of nodetype : ${nodetype}": }
	
	if $nodetype == 'cntrnode' {

		include openstack::cntlrnode

	}elsif $nodetype == 'networknode' {

		include openstack::networknode

	}elsif $nodetype == 'comptnode' {

		include openstack::comptnode

	}elsif $nodetype == 'blocknode' {

		include openstack::blocknode

	}
}