class test3::case2{
	#$mGMT_NETIP_CONTROLLER = $openstack::mGMT_NETIP_CONTROLLER

	#notify { "The value of nodetype2 : ${nodetype}": }
	#notify { "The value of mGMT_NETIP_CONTROLLER2 : $mGMT_NETIP_CONTROLLER": }
	notify { "Run test3::case2": }

}