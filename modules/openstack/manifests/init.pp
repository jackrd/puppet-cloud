class openstack (
        $mGMT_NETIP_CONTROLLER  =  hiera('$openstack::params::mGMT_NETIP_CONTROLLER', $openstack::params::mGMT_NETIP_CONTROLLER),
        $mGMT_NETIP_NETWORK  =  hiera('$openstack::params::mGMT_NETIP_NETWORK', $openstack::params::mGMT_NETIP_NETWORK),
        $mGMT_NETIP_COMPUTE1  =  hiera('$openstack::params::mGMT_NETIP_COMPUTE1', $openstack::params::mGMT_NETIP_COMPUTE1),
        $mGMT_NETMASK  =  hiera('$openstack::params::mGMT_NETMASK', $openstack::params::mGMT_NETMASK),
        $mGMT_GATEWAY  =  hiera('$openstack::params::mGMT_GATEWAY', $openstack::params::mGMT_GATEWAY),
        $iNST_TUNIP_NETWORK  =  hiera('$openstack::params::iNST_TUNIP_NETWORK', $openstack::params::iNST_TUNIP_NETWORK),
        $iNST_TUNIP_COMPUTE1  =  hiera('$openstack::params::iNST_TUNIP_COMPUTE1', $openstack::params::iNST_TUNIP_COMPUTE1),
        $nIC_DEV_NAME_01  =  hiera('$openstack::params::nIC_DEV_NAME_01', $openstack::params::nIC_DEV_NAME_01),
        $nIC_DEV_NAME_02  =  hiera('$openstack::params::nIC_DEV_NAME_02', $openstack::params::nIC_DEV_NAME_02),
        $nIC_DEV_NAME_03  =  hiera('$openstack::params::nIC_DEV_NAME_03', $openstack::params::nIC_DEV_NAME_03),
        $nIC_DEV_NAME_04  =  hiera('$openstack::params::nIC_DEV_NAME_04', $openstack::params::nIC_DEV_NAME_04),
        $nodetype  =  hiera('$openstack::params::nodetype', $openstack::params::nodetype),
        $rABBIT_HOST  =  hiera('$openstack::params::rABBIT_HOST', $openstack::params::rABBIT_HOST),
        $rABBIT_PASS  =  hiera('$openstack::params::rABBIT_PASS', $openstack::params::rABBIT_PASS),
        $aDMIN_PASS  =  hiera('$openstack::params::aDMIN_PASS', $openstack::params::aDMIN_PASS),
        $aDMIN_EMAIL  =  hiera('$openstack::params::aDMIN_EMAIL', $openstack::params::aDMIN_EMAIL),
        $aDMIN_TOKEN  =  hiera('$openstack::params::aDMIN_TOKEN', $openstack::params::aDMIN_TOKEN),
        $aUTH_HOST  =  hiera('$openstack::params::aUTH_HOST', $openstack::params::aUTH_HOST),
        $db_username  =  hiera('$openstack::params::db_username', $openstack::params::db_username),
        $db_passwd  =  hiera('$openstack::params::db_passwd', $openstack::params::db_passwd),
        $kEYSTONE_DBPASS  =  hiera('$openstack::params::kEYSTONE_DBPASS', $openstack::params::kEYSTONE_DBPASS),
        $keystone_db_name  =  hiera('$openstack::params::keystone_db_name', $openstack::params::keystone_db_name),
        $keystone_db_passwd  =  hiera('$openstack::params::keystone_db_passwd', $openstack::params::keystone_db_passwd),
        $oS_USERNAME  =  hiera('$openstack::params::oS_USERNAME', $openstack::params::oS_USERNAME),
        $oS_PASSWORD  =  hiera('$openstack::params::oS_PASSWORD', $openstack::params::oS_PASSWORD),
        $oS_TENANT_NAME  =  hiera('$openstack::params::oS_TENANT_NAME', $openstack::params::oS_TENANT_NAME),
        $oS_AUTH_URL  =  hiera('$openstack::params::oS_AUTH_URL', $openstack::params::oS_AUTH_URL),
        $os_service_token  =  hiera('$openstack::params::os_service_token', $openstack::params::os_service_token),
        $os_service_endpoint  =  hiera('$openstack::params::os_service_endpoint', $openstack::params::os_service_endpoint),
        $gLANCE_DBPASS  =  hiera('$openstack::params::gLANCE_DBPASS', $openstack::params::gLANCE_DBPASS),
        $gLANCE_PASS  =  hiera('$openstack::params::gLANCE_PASS', $openstack::params::gLANCE_PASS),
        $gLANCE_EMAIL  =  hiera('$openstack::params::gLANCE_EMAIL', $openstack::params::gLANCE_EMAIL),
        $glance_db_name  =  hiera('$openstack::params::glance_db_name', $openstack::params::glance_db_name),
        $glance_db_passwd  =  hiera('$openstack::params::glance_db_passwd', $openstack::params::glance_db_passwd),
        $nOVA_DBPASS  =  hiera('$openstack::params::nOVA_DBPASS', $openstack::params::nOVA_DBPASS),
        $nOVA_PASS  =  hiera('$openstack::params::nOVA_PASS', $openstack::params::nOVA_PASS),
        $nOVA_EMAIL  =  hiera('$openstack::params::nOVA_EMAIL', $openstack::params::nOVA_EMAIL),
        $nova_db_name  =  hiera('$openstack::params::nova_db_name', $openstack::params::nova_db_name),
        $nova_db_passwd  =  hiera('$openstack::params::nova_db_passwd', $openstack::params::nova_db_passwd),
        $nEUTRON_PASS  =  hiera('$openstack::params::nEUTRON_PASS', $openstack::params::nEUTRON_PASS),
        $nEUTRON_DBPASS  =  hiera('$openstack::params::nEUTRON_DBPASS', $openstack::params::nEUTRON_DBPASS),
        $nEUTRON_EMAIL  =  hiera('$openstack::params::nEUTRON_EMAIL', $openstack::params::nEUTRON_EMAIL),
        $neutron_db_name  =  hiera('$openstack::params::neutron_db_name', $openstack::params::neutron_db_name),
        $neutron_db_passwd  =  hiera('$openstack::params::neutron_db_passwd', $openstack::params::neutron_db_passwd),
        $mETADATA_SECRET  =  hiera('$openstack::params::mETADATA_SECRET', $openstack::params::mETADATA_SECRET),
        $iNTERFACE_NAME  =  hiera('$openstack::params::iNTERFACE_NAME', $openstack::params::iNTERFACE_NAME),
        $fLOATING_IP_START  =  hiera('$openstack::params::fLOATING_IP_START', $openstack::params::fLOATING_IP_START),
        $fLOATING_IP_END  =  hiera('$openstack::params::fLOATING_IP_END', $openstack::params::fLOATING_IP_END),
        $eXTERNAL_NETWORK_GATEWAY  =  hiera('$openstack::params::eXTERNAL_NETWORK_GATEWAY', $openstack::params::eXTERNAL_NETWORK_GATEWAY),
        $eXTERNAL_NETWORK_CIDR  =  hiera('$openstack::params::eXTERNAL_NETWORK_CIDR', $openstack::params::eXTERNAL_NETWORK_CIDR),
        $tENANT_NETWORK_GATEWAY  =  hiera('$openstack::params::tENANT_NETWORK_GATEWAY', $openstack::params::tENANT_NETWORK_GATEWAY),
        $tENANT_NETWORK_CIDR  =  hiera('$openstack::params::tENANT_NETWORK_CIDR', $openstack::params::tENANT_NETWORK_CIDR),
) inherits openstack::params{

	notify { "The value of nodetype : ${nodetype}": }

	if $nodetype == 'cntlrnode' {

		include openstack::cntlrnode

	}elsif $nodetype == 'networknode' {

		include openstack::networknode

	}elsif $nodetype == 'comptnode' {

		include openstack::comptnode

	}
}